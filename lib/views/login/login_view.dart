import 'package:cgwallet/common/common.dart';
import 'package:cgwallet/common/widgets/my_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'index.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      backgroundColor: Theme.of(context).myColors.background,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return MyAppBar.transparent(
      context: context,
      actions: [
        MyButton.icon(onPressed: () {}, icon: Theme.of(context).myIcons.customer)
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLogo(context),
        const SizedBox(height: 20),
        Obx(() => _buildContent(context)),
      ]
    ));
  }

  Widget _buildTitle(BuildContext context) {
    final background = controller.state.signState.value == SignState.loginForPassword
      ? Theme.of(context).myIcons.loginTitleBackgroundLeft
      : Theme.of(context).myIcons.loginTitleBackgroundRight;

    final leftSelect = Stack(alignment: AlignmentDirectional.center, children: [
      const SizedBox(width: double.infinity, height: 60),
      Positioned(bottom: 4, child: Theme.of(context).myIcons.loginTitleSelect),
      FittedBox(child: Text(Lang.loginViewTitleLogin.tr, style: Theme.of(context).myStyles.loginTitleSelect)),
    ]);

    final rightSelect = Stack(alignment: AlignmentDirectional.center, children: [
      const SizedBox(width: double.infinity, height: 60),
      Positioned(bottom: 4, child: Theme.of(context).myIcons.loginTitleSelect),
      FittedBox(child: Text(Lang.loginViewTitleRegister.tr, style: Theme.of(context).myStyles.loginTitleSelect)),
    ]);

    final leftUnselect = MyButton.text(onPressed: controller.onLoginPage, text: Lang.loginViewTitleLogin.tr, fontSize: 16);
    final rightUnselect = MyButton.text(onPressed: controller.onRegister, text: Lang.loginViewTitleRegister.tr, fontSize: 16);

    final left = controller.state.signState.value == SignState.loginForPassword
      ? leftSelect
      : leftUnselect;

    final right = controller.state.signState.value == SignState.register
      ? rightSelect
      : rightUnselect;

    final content = Row(children: [Expanded(child: left), Expanded(child: right)]);

    return Stack(
      alignment: controller.state.signState.value == SignState.loginForPassword
        ? AlignmentDirectional.centerStart
        : AlignmentDirectional.centerEnd,
      children: [background, content]
    );
  }

  Widget _buildContent(BuildContext context) {
    return MyCard.login(context, Column(children: [
      if (controller.state.signState.value != SignState.forgotPassword)
        _buildTitle(context),
      if (controller.state.signState.value == SignState.loginForPassword)
        _buildLoginForPasswordPage(context),
    ]));
  }
  Widget _buildLoginForPasswordPage(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(children: [
        const SizedBox(height: 32),
        MyInput.account(context, controller.accountTextController, controller.accountFocusNode),
        const SizedBox(height: 10),
        MyInput.password(context, controller.passwordTextController, controller.passwordFocusNode),
        const SizedBox(height: 10),
        MyInput.pictureCode(context, controller.pictureTextController, controller.pictureFocusNode, controller.state.captchForPassword),
        const SizedBox(height: 10),
        _buildRemenberAccountButtton(context),

        const SizedBox(height: 32),
        MyButton.filedLong(onPressed: controller.onLoginForPassword, text: Lang.loginViewLogin.tr),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          MyButton.text(onPressed: () {}, text: Lang.loginViewLoginForCode.tr, textColor: Theme.of(context).myColors.primary),
          MyButton.text(onPressed: () {}, text: Lang.loginViewForgotPassword.tr),
        ])
      ]),
    );
  }

  Widget _buildRemenberAccountButtton(BuildContext context) {
    final child = Row(children: [
      const SizedBox(width: 8),
      Obx(() => controller.state.isRemenberPassword ? Theme.of(context).myIcons.singleChecked : Theme.of(context).myIcons.singleUncheck),
      const SizedBox(width: 8),
      Text(Lang.loginViewRemenberAccount.tr, style: Theme.of(context).myStyles.labelText)
    ]);
    return MyButton.widget(onPressed: controller.onRemenberAccount, child: child);
  }

  Widget _buildLogo(BuildContext context) {
    return Theme.of(context).myIcons.logo;
  }
}
