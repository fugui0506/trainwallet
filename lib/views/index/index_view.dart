import 'package:cgwallet/common/common.dart';
import 'package:cgwallet/common/widgets/my_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.normal(context: context, title: controller.title),
      body: _buildBody(context),
      backgroundColor: Theme.of(context).myColors.background,
    );
  }

  Widget _buildBody(BuildContext context) {
    return PageView(
      children: [
        _buildPage1(context),
        _buildPage2(context),
        _buildPage3(context),
      ],
    );
  }

  Widget _buildPage1(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 10,
        runSpacing: 0,
        children: [
          Row(children: [
            Expanded(child: Obx(() => MyButton.filedLong(onPressed: () => MyTheme.changeThemeMode(2), text: '亮色主题', backgroundColor: DeviceService.to.themeMode.value == 2 ? Theme.of(context).myColors.error : Theme.of(context).myColors.primary))),
            const SizedBox(width: 10),
            Expanded(child: Obx(() => MyButton.filedLong(onPressed: () => MyTheme.changeThemeMode(1), text: '暗色主题', backgroundColor: DeviceService.to.themeMode.value == 1 ? Theme.of(context).myColors.error : Theme.of(context).myColors.primary))),
            const SizedBox(width: 10),
            Expanded(child: Obx(() => MyButton.filedLong(onPressed: () => MyTheme.changeThemeMode(0), text: '跟随系统', backgroundColor: DeviceService.to.themeMode.value == 0 ? Theme.of(context).myColors.error : Theme.of(context).myColors.primary))),
          ]),

          Row(children: [
            Expanded(child: MyButton.filedShort(onPressed: () async {
              MyAudio.to.play(MyAudioPath.click);

              await DioService.to.post<UserInfoModel>(ApiPath.base.accountLogin, 
                onSuccess: (code, msg, data) {
                  UserController.to.userInfo.value = data;
                  UserController.to.userInfo.update((val) {});
                },
                onModel: (json) => UserInfoModel.fromJson(json),
                data: {
                  "username": "fugui006",
                  "password": 'Fugui006'.encrypt(MyConfig.key.aesKey),
                  "captcha": "12222",
                  "captchaId": "898",
                }
              );
            }, text: '账号登录')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () async {
              MyAudio.to.play(MyAudioPath.click);
              await DioService.to.post(ApiPath.base.logout,
                onSuccess: (code, msg, data) {
                  UserController.to.userInfo.update((val) {
                    val!.token = '';
                  });
                },
              );
            }, text: '退出登录')),
          ]),
          
          Row(children: [
            Expanded(child: MyButton.filedShort(onPressed: () => WebSocketService.to.reset(), text: '连接 WS')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => WebSocketService.to.close(), text: '断开 WS')),
          ]),
        
          Row(children: [
            Expanded(child: MyButton.filedShort(onPressed: () async {
              const url = 'https://volume2.3333d.vip/7,dac7733f8005';
              final bytes = await DioService.to.downloadImage(url);
              if (bytes != null) {
                controller.state.imageBytes.value = bytes;
                controller.state.imageBytes.refresh();
              }
            }, text: '下载图片')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedLong(onPressed: () async {
              final result = await Get.toNamed(MyRoutes.scanView);
              if (result != null) {
                MyLogger.w(result);
              }
            }, text: '扫描')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedLong(onPressed: () => DeviceService.to.pickAndDecodeQRCode(), text: '识别')),
          ]),

          MyButton.filedLong(onPressed: () => Get.toNamed(MyRoutes.webView), text: '打开浏览器'),

          Row(children: [
            Expanded(child: MyButton.filedShort(onPressed: () => MyAudio.to.play(MyAudioPath.achievement), text: 'achi')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => MyAudio.to.play(MyAudioPath.click), text: 'click')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => MyAudio.to.play(MyAudioPath.dialog), text: 'dialog')),
          ]),
          
          Row(children: [
            Expanded(child: MyButton.filedShort(onPressed: () => MyAudio.to.play(MyAudioPath.scan), text: 'scan')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => MyAudio.to.play(MyAudioPath.coinDrop), text: 'coin')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => MyAudio.to.play(MyAudioPath.setting), text: 'setting')),
          ]),

          Row(children: [
            Expanded(child: MyButton.filedShort(onPressed: () => MyAlert.snackbar('message'), text: 'SnackBar弹窗')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () {
              MyAlert.loading(context);
            }, text: 'Loading弹窗')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => MyAlert.dialog(
              title: '测试全部都有',
              message: '没事，我就受不了我就受不了我就受不了我就受不了我就受不了我就受不了我就受不了我就受不了我就受不了我就受不了我就受不了',
              confirmText: '我忍',
              // cancelText: '我拒绝',
              onConfirm: () {

              },
              onCancel: () {

              },
              showCancelButton: true,
              showConfirmButton: true,
            ), text: 'Alert弹窗')),
          ]),

          Row(children: [
            Expanded(child: Obx(() => MyButton.filedShort(onPressed: () => MyLang.updateLocale('zh_Hans_CN', true), text: '中文', backgroundColor: DeviceService.to.locale.value == const Locale('zh', 'Hans_CN') ? Theme.of(context).myColors.error : Theme.of(context).myColors.primary,))),
            const SizedBox(width: 10),
            Expanded(child: Obx(() => MyButton.filedShort(onPressed: () => MyLang.updateLocale('en_US', true), text: 'English', backgroundColor: DeviceService.to.locale.value == const Locale('en', 'US') ? Theme.of(context).myColors.error : Theme.of(context).myColors.primary,))),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => MyLang.systemLocale(), text: '系统语言')),
          ]),

          Row(children: [
            Expanded(child: MyButton.filedShort(onPressed: () => Get.offAllNamed(MyRoutes.loginView), text: '登录页')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => Get.offAllNamed(MyRoutes.frameView), text: '首页')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () {}, text: '登录页')),
          ]),

          // Obx(() => controller.state.imageBytes.isEmpty ? const SizedBox() : Image.memory(Uint8List.fromList(controller.state.imageBytes))),
          // MyImage(imageUrl: 'https://volume2.3333d.vip/7,dac7733f8005')

        ],
      ),
    );
  }

  Widget _buildPage2(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 10,
        runSpacing: 0,
        children: [
          Theme.of(context).myIcons.inputCode,
          Theme.of(context).myIcons.inputFundPassword,
          Theme.of(context).myIcons.inputHide,
          Theme.of(context).myIcons.inputPassword,
          Theme.of(context).myIcons.inputPerson,
          Theme.of(context).myIcons.inputPhoneCode,
          Theme.of(context).myIcons.inputPhone,
          Theme.of(context).myIcons.inputShow,
          Theme.of(context).myIcons.inputClear,


          Theme.of(context).myIcons.loginTitleSelect,
        ],
      ),
    );
  }

  Widget _buildPage3(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 10,
        runSpacing: 0,
        children: [
          MyInput.account(context, TextEditingController(), FocusNode()),
          MyInput.account(context, TextEditingController(), FocusNode()),
          MyInput.account(context, TextEditingController(), FocusNode()),
        ],
      ),
    );
  }
}
