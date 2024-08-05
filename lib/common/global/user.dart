import 'dart:async';

import 'package:get/get.dart';

import '../common.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();
  // 初始化等待方法
  final Completer<void> _initCompleter = Completer<void>();
  Future<void> get initComplete => _initCompleter.future;

  // 用户信息
  final userInfo = UserInfoModel.empty().obs;

  // lastIp
  String lastIp = '';
  String lastLoginTime = '';

  @override
  void onInit() {
    super.onInit();
    _initCompleter.complete();
  }

  Future<void> updateUserInfo() async {
    userInfo.update((val) async => await val!.update());
  }
}
