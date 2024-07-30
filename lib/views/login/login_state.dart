
import 'package:get/get.dart';

import '../../common/common.dart';

class LoginState {
  final captchForCode = CaptchaModel.empty().obs;
  final captchForPassword = CaptchaModel.empty().obs;
  final captchForRegister = CaptchaModel.empty().obs;

  final signState = SignState.loginForPassword.obs;

  final isShow = false.obs;

  final _isRemenberPassword = false.obs;
  bool get isRemenberPassword => _isRemenberPassword.value;
  set isRemenberPassword(bool value) => _isRemenberPassword.value = value;
}

enum SignState {
  loginForPassword,
  loginForCode,
  register,
  forgotPassword,
}
