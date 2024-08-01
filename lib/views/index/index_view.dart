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
                  UserService.to.userInfo.value = data;
                  UserService.to.userInfo.update((val) {});
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
                  UserService.to.userInfo.update((val) {
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
              const url = 'https://media.istockphoto.com/id/1409888072/photo/asian-female-artist-draws-create-art-piece-with-palette-and-brush-painting-at-studio.jpg?s=2048x2048&w=is&k=20&c=XVOeKLyO-5Xv6ztxNwy8NmFw0ODWEfExTlfNClpIdo4=';
              MyLogger.w(url);
              await DioService.to.downloadImage(url, onReceiveProgress: (courr, coumt) {
                MyLogger.w('$courr / $coumt');
              });
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
              message: '没事，我从全部收款方式那里去拿一下，把没有的去掉就行，我只是不想他们提这个需求，他们还说是 bug，我就受不了',
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
            Expanded(child: MyButton.filedShort(onPressed: () => Get.toNamed(MyRoutes.loginView), text: '登录页')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => Get.toNamed(MyRoutes.loginView), text: '登录页')),
            const SizedBox(width: 10),
            Expanded(child: MyButton.filedShort(onPressed: () => Get.toNamed(MyRoutes.loginView), text: '登录页')),
          ]),
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

          Theme.of(context).myIcons.singleChecked,
          Theme.of(context).myIcons.singleUncheck,
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
