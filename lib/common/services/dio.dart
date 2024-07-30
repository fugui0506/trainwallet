import 'dart:async';
import 'dart:convert';
import 'package:cgwallet/common/widgets/my_alert.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../common.dart';

class DioService extends GetxService {
  static DioService get to => Get.find();

  final Completer<void> _initCompleter = Completer<void>();
  Future<void> get initComplete => _initCompleter.future;

  late final Dio dio;

  DioService() {
    dio = Dio(_getDioOptions());
    dio.interceptors.add(_getInterceptorsWrapper());
  }

  BaseOptions _getDioOptions() {
    return BaseOptions(
      baseUrl: MyConfig.urls.baseUrl,
      connectTimeout: MyConfig.app.timeOut,
      receiveTimeout: MyConfig.app.timeOut,
      sendTimeout: MyConfig.app.timeOut,
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
  }

  InterceptorsWrapper _getInterceptorsWrapper() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll({
          if (UserService.to.userInfo.value.token.isNotEmpty)
            'x-token': UserService.to.userInfo.value.token,
          'x-timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
          'x-device': DeviceService.to.deviceId,
        });
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        return handler.next(response);
      },
      onError: (DioException err, handler) {
        MyLogger.dioErr('DioService Error', '', err);
        return handler.next(err);
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    await getEnvironment();
    _initCompleter.complete();
    MyLogger.w('DioService 初始化完成...');
  }

  Future<void> get<T>(
    String path, {
    Function(int code, String msg, T data)? onSuccess,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    T Function(Map<String, dynamic>)? onModel,
    Function(DioException?)? onError,
  }) async {
    try {
      final response = await dio.get(path,
        queryParameters: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      final responseModel = ResponseModel.fromJson(response.data);
      MyLogger.http('get', path, response, responseModel);

      if (responseModel.code == 0) {
        final model = onModel != null ? onModel(responseModel.data) : responseModel.data as T;
        onSuccess?.call(responseModel.code, responseModel.msg, model);
      } else {
        onError?.call(null);
      }
    } on DioException catch (e) {
      MyLogger.dioErr('get', path, e);
      MyAlert.snackbar('$e');
      onError?.call(e);
    }
  }

  Future<void> post<T>(
    String path, {
    Function(int code, String msg, T data)? onSuccess,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    T Function(Map<String, dynamic>)? onModel,
    Function(DioException?)? onError,
  }) async {
    try {
      final response = await dio.post(path,
        data: data,
        cancelToken: cancelToken,
      );

      final responseModel = ResponseModel.fromJson(response.data);
      MyLogger.http('post', path, response, responseModel);

      if (responseModel.code == 0) {
        final model = onModel != null ? onModel(responseModel.data) : responseModel.data as T;
        onSuccess?.call(responseModel.code, responseModel.msg, model);
      } else {
        onError?.call(null);
      }
    } on DioException catch (e) {
      MyLogger.dioErr('post', path, e);
      onError?.call(e);
    }
  }

  Future<void> downloadImage(String url, {
    Function(bool success)? callBack,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await dio.get(url,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: onReceiveProgress,
      );

      final imageFile = await DeviceService.to.saveImageToTemp(response.data);

      if (imageFile != null) {
        final result = await DeviceService.to.saveImageToGallery(imageFile);
        callBack?.call(result);
      } else {
        callBack?.call(false);
      }
    } catch (e) {
      MyLogger.w('图片下载出错 --> $e');
      callBack?.call(false);
    }
  }

  Future<void> getEnvironment() async {
    // 获取环境变量
    const String environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'test');
    MyLogger.w('正在读取外部参数: $environment');

    switch (environment) {
      case 'test':
        await _getConfig(MyConfig.urls.testUrl);
        break;
      case 'pre':
        await _getConfig(MyConfig.urls.preUrl);
        break;
      case 'rel':
        await _getConfig(MyConfig.urls.relUrl);
        break;
      default:
        await _getConfig(MyConfig.urls.preUrl);
    }
  }

  Future<void> _getConfig(String url) async {
    try {
      final response = await dio.get(url,
        options: Options(responseType: ResponseType.plain),
      );

      if (response.statusCode == 200) {
        // 链接有效
        final data = response.data.toString().decrypt(MyConfig.key.aesKey);
        final json = jsonDecode(data);

        MyLogger.w('配置信息获取成功：${response.data}');
        MyLogger.w('配置信息：$json', isNewline: false);

        final List<dynamic> baseUrls = json['api'];
        for (var element in baseUrls) {
          try {
            final isWork = await dio.get('$element/health');
            if (isWork.statusCode == 200) {
              MyConfig.urls.baseUrl = element;
              MyLogger.w('检测到有效的 API 地址 --> $element');
              break;
            } else {
              MyLogger.w('$element API 测试无效');
            }
          } catch (err) {
            MyLogger.w('$element API 测试出现错误 --> $err');
          }
        }

        final List<dynamic> wss = json['ws'];
        for (var element in wss) {
          try {
            final isWork = await dio.get(url.replaceFirst('ws', 'http'), 
              options: Options(responseType: ResponseType.plain)
            );
            if (isWork.statusCode == 200) {
              MyConfig.urls.wsUrl = element;
              MyLogger.w('检测到有效的 ws 地址 --> $element');
              break;
            } else {
              MyLogger.w('$element ws 测试无效');
            }
          } catch (err) {
            MyLogger.w('$element ws 测试出现错误 --> $err');
          }
        }

        final List<dynamic> androidDownloads = List.from(json['android_download']);
        for (var element in androidDownloads) {
          try {
            final isWork = await dio.get(element, options: Options(responseType: ResponseType.plain));
            if (isWork.statusCode == 200) {
              MyConfig.urls.downloadAndroidUrl = element;
              MyLogger.w('检测到有效的 Android 下载地址 --> $element');
              break;
            } else {
              MyLogger.w('$element Android 下载地址 测试无效');
            }
          } catch (err) {
            MyLogger.w('$element Android 下载地测试出现错误 --> $err');
          }
        }

        final List<dynamic> iosDownloads = json['ios_download'];
        for (var element in iosDownloads) {
          try {
            final isWork = await dio.get(element, options: Options(responseType: ResponseType.plain));
            if (isWork.statusCode == 200) {
              MyConfig.urls.downloadIOSUrl = element;
              MyLogger.w('检测到有效的 IOS 下载地址 --> $element');
              break;
            } else {
              MyLogger.w('$element IOS 下载地址测试无效');
            }
          } catch (err) {
            MyLogger.w('$element IOS 下载地测试出现错误 --> $err');
          }
        }
      } else {
        // 链接失效
        MyLogger.w('获取配置发生了错误 --> 没有找到可用的配置链接');
      }
    } catch (e) {
      // 链接失效
      MyLogger.w('获取配置发生了错误 --> $e');
    }

    dio.options.baseUrl = MyConfig.urls.baseUrl;

    MyLogger.w('baseUrl: ${MyConfig.urls.baseUrl}');
    MyLogger.w('wsUrl: ${MyConfig.urls.wsUrl}', isNewline: false);
    MyLogger.w('安卓下载地址: ${MyConfig.urls.downloadAndroidUrl}', isNewline: false);
    MyLogger.w('ios 下载地址: ${MyConfig.urls.downloadIOSUrl}', isNewline: false);
  }
}
