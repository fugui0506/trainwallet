import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

import '../common.dart';

class WebSocketService extends GetxService {
  static WebSocketService get to => Get.find();

  final Completer<void> _initCompleter = Completer<void>();
  Future<void> get initComplete => _initCompleter.future;

  // WebSocket 连接对象
  IOWebSocketChannel? _webSocketChannel;

  // 心跳定时器 和 发送心跳的时间
  Timer? _heartbeatTimer;

  // 延迟重连的定时器
  Timer? _retryTimer;

  // 连接状态
  bool _isConnected = false;
  bool _isConnecting = false;

  // 是否主动断开用户主动断开连接
  // 如果是主动断开的，就不重连了
  bool _isClosedByUser = false;

  // 重连相关
  int _retryAttempts = 0; // 当前重连次数

  // WebSocket 初始化
  @override
  void onInit() async {
    super.onInit();
    _initCompleter.complete();
    MyLogger.w('WebSocketService 初始化完成...');
  }

  @override
  void onClose() {
    close();
    super.onClose();
  }

  // ws 重置到初始化状态
  void reset() {
    if (UserService.to.userInfo.value.token.isEmpty) return;
    close().then((_) => _retryConnection());
  }

  /// WebSocket 连接方法
  Future<void> _connectWebSocket() async {
    if (_isConnected || _isConnecting) return;
    _isConnecting = true;
    try {
      _webSocketChannel = IOWebSocketChannel.connect(
        Uri.parse(MyConfig.urls.wsUrl), // 替换为实际的 WebSocket URL
        headers: {
          'x-token': UserService.to.userInfo.value.token, // 替换为实际的 token
        },
        pingInterval: const Duration(seconds: 5),
        connectTimeout: const Duration(seconds: 10),
        customClient: HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true
      );

      await _webSocketChannel?.ready;

      _webSocketChannel?.stream.listen(
        _onMessageReceived,
        onDone: _onConnectionDone,
        onError: _onConnectionError,
        cancelOnError: true,
      );

      _isConnected = true;
      _isClosedByUser = false;
      _isConnecting = false;
      _retryAttempts = 0;
      _cancelTimer(_retryTimer);
      _sendHeartBeat();

      MyLogger.w('✅✅✅✅✅ WebSocket 连接成功 --- ${DateTime.now()}', isNewline: false);
    } catch (e) {
      MyLogger.w('😭😭😭😭😭 WebSocket 连接失败 -- ${DateTime.now()}', isNewline: false);
      MyLogger.w(e, isNewline: false);
      _isClosedByUser = false;
      _isConnecting = false;
      _cancelTimer(_retryTimer);
      _retryConnection();
    }
  }

  void _cancelTimer(Timer? timer) {
    timer?.cancel();
    timer = null;
  }

  /// 处理接收到的消息
  void _onMessageReceived(message) {
    final messageDecode = MyCharacter.decode(message);
    MyLogger.w('<<<<< ✅ 接收到消息（ ${DateTime.now()} ) --> $messageDecode', isNewline: false);
  }

  /// WebSocket 连接关闭时处理
  void _onConnectionDone() {
    MyLogger.w('❌❌❌❌❌ WebSocket 已经关闭 -- ${DateTime.now()}');
    if (!_isClosedByUser) reset();
  }

  /// WebSocket 连接错误时处理
  void _onConnectionError(error) {
    MyLogger.w('❌❌❌❌❌ WebSocket 连接错误 -- ${DateTime.now()}');
    MyLogger.w(error.toString());
    reset();
  }

  /// 重连机制
  void _retryConnection() {
    if (_retryAttempts < MyConfig.app.maxRetryAttempts) {
      _retryAttempts++;
      MyLogger.w('🔄🔄🔄🔄🔄 尝试连接 -- 第$_retryAttempts次 -- ${DateTime.now()}');
      // _retryTimer = Future.delayed(_retryInterval * (_retryAttempts - 1), () => _connectWebSocket());
      _retryTimer = Timer(MyConfig.app.timeRetry * (_retryAttempts - 1), () async {
        if (_isConnecting) {
          MyLogger.w('👋👋👋👋👋 正在连接中。。。 -- ${DateTime.now()}', isNewline: false);
          _retryConnection();
          return;
        }
        if (UserService.to.userInfo.value.token.isEmpty) {
          MyLogger.w('😭😭😭😭😭 未获取到 token -- ${DateTime.now()}', isNewline: false);
          _retryConnection();
          return;
        }
        await _connectWebSocket();
      });
    } else {
      _cancelTimer(_retryTimer);
      _cancelTimer(_heartbeatTimer);
      MyLogger.w('🛑🛑🛑🛑🛑 达到最大重连次数，停止重连 -- ${DateTime.now()}');
    }
  }

  /// 发送心跳包
  void _sendHeartBeat() {
    _cancelTimer(_heartbeatTimer);
    _heartbeatTimer = Timer.periodic(MyConfig.app.timeHeartbeat, (timer) {
      send(MyCharacter.encode({"type": 9}));
    });
  }

  /// 连接 WebSocket
  Future<void> connect() async {
    if (_isConnected || _isConnecting) return;
    _retryConnection();
  }

  /// 断开 WebSocket 连接
  Future<void> close() async {
    _isClosedByUser = true;
    _cancelTimer(_retryTimer);
    _cancelTimer(_heartbeatTimer);
    _isConnected = false;
    _retryAttempts = 0;
    try {
      await _webSocketChannel?.sink.close().timeout(MyConfig.app.timeRetry, onTimeout: () {
        MyLogger.w('>>>>> ⏰ ws 关闭操作超时 ${DateTime.now()} )');
        return null;
      });
    } catch (e) {
      MyLogger.w('>>>>> ❌ ws 关闭时发生错误: $e');
    } finally {
      _webSocketChannel = null;
    }
  }

  /// 发送消息
  void send(data) {
    if (_isConnected && _webSocketChannel != null) {
      try {
        _webSocketChannel?.sink.add(data);
        MyLogger.w('>>>>> 🆕 消息发送成功（ ${DateTime.now()} ) --> ${MyCharacter.decode(data)}');
      } catch (e) {
        MyLogger.w('>>>>> 😔 消息发送失败（ ${DateTime.now()} ) --> $e', isNewline: false);
        _retryConnection();
      }
    } else {
      _retryConnection();
    }
  }
}
