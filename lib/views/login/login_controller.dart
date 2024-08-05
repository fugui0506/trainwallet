// import 'package:captcha_plugin_flutter/captcha_plugin_flutter.dart';
import 'package:captcha_plugin_flutter/captcha_plugin_flutter.dart';
import 'package:cgwallet/common/widgets/my_alert.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../common/common.dart';
import 'index.dart';

class LoginController extends GetxController {
  final state = LoginState();
  final scrollController = ScrollController();

  final accountTextController = TextEditingController();
  final accountFocusNode = FocusNode();

  final passwordTextController = TextEditingController();
  final passwordFocusNode = FocusNode();

  final repasswordTextController = TextEditingController();
  final repasswordFocusNode = FocusNode();

  final caputcharTextController = TextEditingController();
  final caputcharFocusNode = FocusNode();

  final phoneTextController = TextEditingController();
  final phoneFocusNode = FocusNode();

  final phoneCodeTextController = TextEditingController();
  final phoneCodeFocusNode = FocusNode();

  final CaptchaPluginFlutter captchaPlugin = CaptchaPluginFlutter();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
  }

  @override
  void onInit() {
    super.onInit();
    setRemberAccount();
    textEditingControllerAddLinster();
  }
  void setRemberAccount() {
    if (SharedService.to.getString(MyConfig.shard.accountKey).isNotEmpty) {
      state.isRemenberPassword = true;
      accountTextController.text = SharedService.to.getString(MyConfig.shard.accountKey);
    }
  }

  void goCustomerView() {
    Get.toNamed(MyRoutes.customerView);
  }

  void goLogin() {
    state.signState.value = SignState.loginForPassword;
    reset();
  }

  void goRegister() {
    state.signState.value = SignState.register;
    reset();
  }

  void goLoginForCode() {
    state.signState.value = SignState.loginForCode;
    reset();
  }

  void goLoginForPasswrod() {
    state.signState.value = SignState.loginForPassword;
    reset();
  }

  void goForgotPassword() {
    state.signState.value = SignState.forgotPassword;
    reset();
  }

  void onLoding(String value) {
    state.isButtonDisable = true;
    state.isLoading = true;
    MyAlert.block();
    state.validate = value;
  }

  void check(void Function() future) {
    Get.focusScope?.unfocus();
    state.isButtonDisable = true;
    showCaptcha(
      onSuccess: (value) async {
        onLoding(value);
        future.call();
      },
      onError: () {
        state.isButtonDisable = false;
      },
      onClose: () {
        state.isButtonDisable = false;
      },
    );
  }

  void onLoginForPassword() {
    check(loginForPassword);
  }

  void onRegister() {
    check(register);
  }

  void onForgotPassword() {
    check(forgotPassword);
  }

  void onLoginForPhoneCode() {
    check(loginForPhoneCode);
  }

  void onRemenberAccount() {
    state.isRemenberPassword = !state.isRemenberPassword;
  }

  void textEditingControllerAddLinster() {
    accountTextController.addListener(linster);
    passwordTextController.addListener(linster);
    repasswordTextController.addListener(linster);
    caputcharTextController.addListener(linster);
    phoneTextController.addListener(linster);
    phoneCodeTextController.addListener(linster);
  }

  void linster() {
    if (state.signState.value == SignState.loginForPassword) {
      if (accountTextController.text.isEmpty || passwordTextController.text.isEmpty) {
        state.isButtonDisable = true;
      } else {
        state.isButtonDisable = false;
      }
    }

    if (state.signState.value == SignState.loginForCode) {
      if (phoneTextController.text.isEmpty || phoneCodeTextController.text.isEmpty) {
        state.isButtonDisable = true;
      } else {
        state.isButtonDisable = false;
      }
    }

    if (state.signState.value == SignState.register) {
      if (accountTextController.text.isEmpty || passwordTextController.text.isEmpty || repasswordTextController.text.isEmpty || phoneTextController.text.isEmpty || phoneCodeTextController.text.isEmpty) {
        state.isButtonDisable = true;
      } else {
        state.isButtonDisable = false;
      }
    }

    if (state.signState.value == SignState.forgotPassword) {
      if (passwordTextController.text.isEmpty || repasswordTextController.text.isEmpty || phoneTextController.text.isEmpty || phoneCodeTextController.text.isEmpty) {
        state.isButtonDisable = true;
      } else {
        state.isButtonDisable = false;
      }
    }
  }

  void reset() {
    Get.focusScope?.unfocus();
    if (state.signState.value == SignState.loginForPassword) {
      setRemberAccount();
    } else {
      accountTextController.text = '';
    }
    passwordTextController.text = '';
    repasswordTextController.text = '';
    caputcharTextController.text = '';
    phoneTextController.text = '';
    phoneCodeTextController.text = '';
    linster();
  }

  // 检查是否被风控
  Future<void> checkRiskControlled() async {
    if (UserController.to.userInfo.value.user.riskMessage.isNotEmpty && UserController.to.userInfo.value.user.enable == 2 && UserController.to.userInfo.value.user.isAuth != 3) {
      final result = await Get.offNamed(MyRoutes.faceVerifiedView);
      if (result == null) {
        state.isLoading = false;
        return;
      }
    }
    
    Get.offAllNamed(MyRoutes.frameView);
    
    if (UserController.to.userInfo.value.user.riskMessage.isNotEmpty && UserController.to.userInfo.value.user.isAuth == 3) {
      MyAlert.snackbar('账号无法完成人脸识别,请联系客服');
    }
  }

  // 设置用户信息：登录成功后
  void setUserInfo(UserInfoModel data) {
    UserController.to.userInfo.value = data;
    UserController.to.userInfo.update((val) {});
    UserController.to.lastIp = data.user.lastIp;
    UserController.to.lastLoginTime = data.user.lastAt;
  }

  Future<void> loginForPassword() async {
    state.isLoading = true;

    await DioService.to.post<UserInfoModel>(ApiPath.base.accountLogin, 
      onSuccess: (code, msg, data) async {
        setUserInfo(data);

        // 是否保存账号信息
        if (state.isRemenberPassword) {
          SharedService.to.setString(MyConfig.shard.accountKey, accountTextController.text);
        } else {
          SharedService.to.remove(MyConfig.shard.accountKey);
        }

        await checkRiskControlled();

      },
      onModel: (json) => UserInfoModel.fromJson(json),
      data: {
        "username": accountTextController.text,
        "password": passwordTextController.text.encrypt(MyConfig.key.aesKey),
        "captcha": caputcharTextController.text,
        "captchaId": state.captchForPassword.value.captchaId,
        'validate': state.validate,
      },
      onError: () {
        Get.back();
        state.isLoading = false;
      }
    );
  }

  Future<void> register() async {
    state.isLoading = true;

    await DioService.to.post<UserInfoModel>(ApiPath.base.register, 
      onSuccess: (code, msg, data) async {
        setUserInfo(data);
        await checkRiskControlled();
      },
      onModel: (json) => UserInfoModel.fromJson(json),
      data: {
        'username': accountTextController.text,
        'phone': phoneTextController.text,
        'password': passwordTextController.text.encrypt(MyConfig.key.aesKey),
        'repassword': repasswordTextController.text.encrypt(MyConfig.key.aesKey),
        'verificationCode': phoneCodeTextController.text,
        'captcha': caputcharTextController.text,
        'captchaId': state.captchForPassword.value.captchaId,
      },
      onError: () {
        Get.back();
        state.isLoading = false;
      }
    );
  }

  Future<void> forgotPassword() async {
    state.isLoading = true;

    await DioService.to.post(ApiPath.base.forgetPassword, 
      onSuccess: (code, msg, data) async {
        goLogin();
        MyAlert.snackbar(msg);
      },
      data: {
        "phone": phoneTextController.text,
        "newPassword": passwordTextController.text.encrypt(MyConfig.key.aesKey),
        "reNewPassword": repasswordTextController.text.encrypt(MyConfig.key.aesKey),
        "verificationCode": phoneCodeTextController.text,
      },
      onError: () {
        Get.back();
        state.isLoading = false;
      }
    );
  }

  Future<void> loginForPhoneCode() async {
    state.isLoading = true;

    await DioService.to.post<UserInfoModel>(ApiPath.base.phoneLogin, 
      onSuccess: (code, msg, data) async {
        setUserInfo(data);
        await checkRiskControlled();
      },
      onModel: (json) => UserInfoModel.fromJson(json),
      data: {
        "phone": phoneTextController.text,
        "verificationCode": phoneCodeTextController.text,
        "captcha": caputcharTextController.text,
        "captchaId": state.captchForPassword.value.captchaId,
        'validate': state.validate,
      },
      onError: () {
        Get.back();
        state.isLoading = false;
      }
    );
  }

  void showCaptcha({void Function(String)? onSuccess, void Function()? onError, void Function()? onClose}) {
    CaptchaPluginConfig styleConfig = CaptchaPluginConfig(
      radius: 10,
      capBarTextColor:"#25D4D0",
      capBarTextSize: 18,
      capBarTextWeight:"bold",
      borderColor:"#25D4D0",
      borderRadius:10,
      backgroundMoving:"#DC143C",
      executeBorderRadius:10,
      executeBackground:"#DC143C",
      capBarTextAlign:"center",
      capPaddingTop:10,
      capPaddingRight:10,
      capPaddingBottom:10,
      capPaddingLeft:10,
      paddingTop:15,
      paddingBottom:15
    );
    String languageType = 'zh-CN';
    if (Get.locale != MyLang.defaultLocale) {
      languageType = 'en-US';
    }
    captchaPlugin.init({
      "captcha_id": MyConfig.key.captchaKey,
      "is_debug": false,
      "dimAmount": 0.8,
      "is_touch_outside_disappear": true,
      "timeout": 8000,
      "is_hide_close_button": false,
      "use_default_fallback": true,
      "failed_max_retry_count": 4,
      "language_type": languageType,
      "is_close_button_bottom":true,
      "styleConfig":styleConfig.toJson(),
    });
    captchaPlugin.showCaptcha(
      onLoaded: () {
        MyLogger.w('网易行为式验证码初始化完毕...');
      },
      onSuccess: (dynamic data) {
        MyLogger.w('网易行为式验证成功...');
        MyLogger.w('$data');
        onSuccess?.call(data['validate']);
      },
      onClose: (dynamic data) {
        MyLogger.w('网易行为式验证退出...');
        onClose?.call();
      },
      onError: (dynamic data) {
        MyLogger.w('网易行为式验证出现错误...');
        onError?.call();
    });
  }
}
