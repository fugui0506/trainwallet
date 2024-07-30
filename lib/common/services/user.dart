import 'dart:async';

import 'package:get/get.dart';

import '../common.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();
  // 初始化等待方法
  final Completer<void> _initCompleter = Completer<void>();
  Future<void> get initComplete => _initCompleter.future;

  // 用户信息
  final userInfo = UserInfoModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    _initCompleter.complete();
  }
}
