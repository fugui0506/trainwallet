import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

import '../common.dart';

class DeviceService extends GetxService with WidgetsBindingObserver {
  static DeviceService get to => Get.find();
  
  // 初始化等待方法
  final Completer<void> _initCompleter = Completer<void>();
  Future<void> get initComplete => _initCompleter.future;

  // 设备信息
  String deviceId = '';
  String platform = '';
  String osversion = '';
  String model = '';

  // 主题模式：系统，亮色，暗色
  // 0:跟随系统
  // 1:暗色模式
  // 2:亮色模式
  final themeMode = SharedService.to.getInt(MyConfig.shard.themeModeKey).obs;

  // 语言设置
  final locale = const Locale('zh', 'CN').obs;

  // 包信息
  PackageInfo packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // 监视 App 是否切换到后台
    switch (state) {
      case AppLifecycleState.resumed:
        MyLogger.w('app 切换到了前台');
        WebSocketService.to.reset();
        _setAndroid();
        MyLang.initLocale();
        break;
      case AppLifecycleState.paused:
        MyLogger.w('app 切换到了后台');
        WebSocketService.to.close();
        break;
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _setAndroid();
  }

  @override
  void onInit() async {
    super.onInit();
    
    WidgetsBinding.instance.addObserver(this);
    
    // 设置主题
    await MyTheme.changeThemeMode(themeMode.value);
    
    // 读取设备信息
    await _readDeviceInfo();

    // 获取包信息
    packageInfo = await PackageInfo.fromPlatform();
    MyLogger.w('APP包信息 --> APP名称: ${packageInfo.appName}', isNewline: false);
    MyLogger.w('APP包信息 --> 版本号: ${packageInfo.version}', isNewline: false);

    // 设置竖屏
    await MyTheme.setPreferredOrientations();
    MyLogger.w('强制竖屏：设置完成...', isNewline: false);

    _initCompleter.complete();
  }

  @override
  void onReady() async {
    super.onReady();
    await MyLang.initLocale();
  }

  // 请求外部储存的读取和写入权限
  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var result = await Permission.storage.request();
      return result == PermissionStatus.granted ? true : false;
    }
    return true;
  }

  // 请求相册的权限
  Future<bool> requestPhotosPermission() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      var result = await Permission.photos.request();
      return result == PermissionStatus.granted ? true : false;
    }
    return true;
  }

  // 请求相机的权限
  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      var result = await Permission.camera.request();
      return result == PermissionStatus.granted ? true : false;
    }
    return true;
  }

  // 获取安卓设备号
  Future<String> getAndroidId() async {
    final platform = MethodChannel(MyConfig.channel.deviceInfo);
    String androidId;
    try {
      final String result = await platform.invokeMethod('getAndroidId');
      androidId = result;
    } on PlatformException catch (e) {
      androidId = "Failed to get Android ID: '${e.message}'.";
    }
    return androidId;
  }

  // 读取设备信息
  Future<void> _readDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (GetPlatform.isAndroid) {
      await _setAndroidInfo(deviceInfo);
    } else if (GetPlatform.isIOS) {
      await _setIOSInfo(deviceInfo);
    }

    MyLogger.w('设备信息：$deviceId', isNewline: false);
  }

  // 设置设备信息：安卓
  Future<void> _setAndroidInfo(DeviceInfoPlugin deviceInfo) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final androidId = await getAndroidId();
    platform = 'Android';
    osversion = 'Android ${androidInfo.version.sdkInt}';
    model = androidInfo.model;
    deviceId = '$platform.${androidInfo.brand}.$model.${androidInfo.id}.$androidId';
    
    // 隐藏安卓手机的底部导航栏
    await MyTheme.removeNavigationBar();
    MyLogger.w('安卓透明状态栏：设置完成...');
  }

  // 设置设备信息：IOS
  Future<void> _setIOSInfo(DeviceInfoPlugin deviceInfo) async {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    platform = 'IOS';
    osversion = 'IOS ${iosInfo.utsname.version}';
    model = iosInfo.model;
    deviceId = iosInfo.identifierForVendor ?? '';
    deviceId = '$platform-$model-$deviceId';
  }

  // 从相册选择图片
  Future<XFile?> pickImage() async {
    try {
      // 请求权限
      await requestPhotosPermission();

      // 使用 ImagePicker 从相册中选择图片
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        MyLogger.w('没有获取到图片...');
      } else {
        MyLogger.w('图片获取成功 --> (${pickedFile.path})');
      }

      return pickedFile;
    } catch (e) {
      MyLogger.w('获取图片失败...');
      return null;
    }
  }

  /// 将图片临时储存
  Future<File?> saveImageToTemp(List<int> bytes) async {
    try {
      // Request storage permission
      bool permissionGranted = await DeviceService.to.requestStoragePermission();
      if (!permissionGranted) {
        throw Exception("Storage permission denied");
      }

      // 获取存储目录
      Directory? extDir = await getApplicationDocumentsDirectory();

      // 创建保存图片的目录
      String directoryPath = extDir.path;

      // 将图片数据写入文件
      File imageFile = File('$directoryPath/${DateTime.now().microsecondsSinceEpoch}.png');
      
      await imageFile.writeAsBytes(bytes);
      MyLogger.w('文件储存成功 --> ${imageFile.path}');
      return imageFile;
    } catch (e) {
      MyLogger.w('文件储存失败');
      return null;
    }
  }

  /// 将图片保存至相册
  Future<bool> saveImageToGallery(File imageFile) async {
    try {
      final channel = MethodChannel(MyConfig.channel.image);
      // Save image to gallery using platform channel
      final result = await channel.invokeMethod('saveImageToGallery', {
        'path': imageFile.path,
      });

      // 删除临时存储的图片
      await DeviceService.to.deleteFile(imageFile);

      MyLogger.w('图片保存: $result');
      return result;
    } catch (e) {
      MyLogger.w('图片保存出错 --> $e');
      return false;
    }
  }

  Future<void> deleteFile(File file) async {
    // 删除选取的图片文件
    try {
      await file.delete();
      MyLogger.w('临时文件删除成功 --> (${file.path})');
    } catch (e) {
      // 打印删除文件时的错误信息
      MyLogger.w('临时文件删除失败 --> (${file.path}) --> $e');
    }
  }

  // 从相册读取图片并识别图片中的二维码
  // Future<bool> pickAndDecodeQRCode() async {
  //   try {
  //     // 使用 ImagePicker 从相册中选择图片
  //     final pickedFile = await pickImage();

  //     if (pickedFile != null) {
  //       String filePath = pickedFile.path;

  //       // 解码二维码
  //       await decodeQRCode(filePath);

  //       // 删除临时文件
  //       await deleteFile(File(filePath));

  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // 识别图片中的二维码
  // Future<bool> decodeQRCode(String filePath) async {
  //   try {
  //     final platform = MethodChannel(MyConfig.channel.channelImage);
  //     final String result = await platform.invokeMethod('decodeQRCode', {"path": filePath});
  //     MyLogger.w('二维码识别结果: $result');
  //     return true;
  //   } catch (e) {
  //     MyLogger.w('未识别到二维码: $e');
  //     return false;
  //   }
  // }

  /// 设置安卓状态栏
  Future<void> _setAndroid() async {
    Brightness brightness;
    switch (themeMode.value) {
      case 1:
        brightness = Brightness.light;
        break;
      case 2:
        brightness = Brightness.dark;
        break;
      default:
        brightness = PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;
    }
    await MyTheme.setAndroidDeviceBar(brightness);
  }

  pickAndDecodeQRCode() {}
}
