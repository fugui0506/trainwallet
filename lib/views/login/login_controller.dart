// import 'package:captcha_plugin_flutter/captcha_plugin_flutter.dart';
import 'package:captcha_plugin_flutter/captcha_plugin_flutter.dart';
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

  final pictureTextController = TextEditingController();
  final pictureFocusNode = FocusNode();

  final CaptchaPluginFlutter captchaPlugin = CaptchaPluginFlutter();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePage);
  }

  @override
  void onInit() {
    super.onInit();
    if (SharedService.to.getString(MyConfig.shard.accountKey).isNotEmpty) {
      state.isRemenberPassword = true;
      accountTextController.text = SharedService.to.getString(MyConfig.shard.accountKey);
    }
  }

  void onLoginPage() {
    state.signState.value = SignState.loginForPassword;
  }

  void onRegister() {
    state.signState.value = SignState.register;
  }

  void onLoginForPassword() {
    showCaptcha();

    if (state.isRemenberPassword) {
      SharedService.to.setString(MyConfig.shard.accountKey, accountTextController.text);
    } else {
      SharedService.to.remove(MyConfig.shard.accountKey);
    }
  }

  void onRemenberAccount() {
    state.isRemenberPassword = !state.isRemenberPassword;
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
    captchaPlugin.init({
      "captcha_id": MyConfig.app.captchaKey,
      "is_debug": false,
      "dimAmount": 0.8,
      "is_touch_outside_disappear": true,
      "timeout": 8000,
      "is_hide_close_button": false,
      "use_default_fallback": true,
      "failed_max_retry_count": 4,
      "language_type": "zh-CN",
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
