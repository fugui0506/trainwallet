part of 'config.dart';

class _App {
  // 请求超时时间
  final Duration timeOut = const Duration(seconds: 30);
  // 等待时间
  final Duration timeWait = const Duration(seconds: 2);
  // 心跳间隔
  final Duration timeHeartbeat = const Duration(seconds: 10);
  // 重连间隔的基数
  final Duration timeRetry = const Duration(seconds: 5);
  // 页面切换动画时长
  final Duration timePageTransition = const Duration(milliseconds: 300);

  // 最大重连次数
  final int maxRetryAttempts = 7;
}