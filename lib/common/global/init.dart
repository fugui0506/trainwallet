import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common.dart';

Future<void> init() async {
  // 运行初始, 用到了servis就需要处初始化，否则会报错
  // 全局只需要使用一次
  WidgetsFlutterBinding.ensureInitialized();

  // 本地储存初始化
  // 可以储存数据在本地
  await Get.putAsync<SharedService>(() => SharedService().init());

  // 导入用户控制器
  // user: 用户控制器
  await Get.put(UserService()).initComplete;

  // 导入全局控制器
  // DeviceService 设备相关的服务
  await Get.put(DeviceService()).initComplete;

  // 导入http连接接口
  // 用户网络请求
  await Get.put(DioService()).initComplete;

  // 初始化 ws 服务
  await Get.put(WebSocketService()).initComplete;

  MyLogger.w(null);
}
