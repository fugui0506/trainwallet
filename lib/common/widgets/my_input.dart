import 'dart:convert';

import 'package:cgwallet/common/common.dart';
import 'package:cgwallet/common/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInput extends StatelessWidget {
  const MyInput({
    super.key,
    this.controller,
    this.focusNode,
    this.maxLines = 1,
    this.textInputAction,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.obscureText = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.onTap,
    this.autofocus = false,
    this.enabled,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 0),
    this.color,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.errorText,
    this.maxLength,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool obscureText;
  final BorderRadiusGeometry borderRadius;
  final void Function()? onTap;
  final bool autofocus;
  final bool? enabled;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final TextAlign textAlign;
  final void Function(String)? onChanged;
  final String? errorText;
  final int? maxLength;

  /// 账号输入框
  factory MyInput.account(BuildContext context, TextEditingController controller, FocusNode focusNode) {
    final showSuffixIcon = false.obs;

    final suffixIcon = Obx(() => showSuffixIcon.value
      ? MyButton.icon(
          onPressed: () {
            controller.text = '';
            showSuffixIcon.value = false;
            // if (!focusNode.hasFocus) focusNode.requestFocus();
          }, 
          icon: Theme.of(context).myIcons.inputClear,
        )
      : const SizedBox());

    void onChanged(String text) {
      if (text.isEmpty) {
        showSuffixIcon.value = false;
      } else {
        showSuffixIcon.value = true;
      }
    }

    final prefixIcon = SizedBox(width: 40, height: 40, child: Center(
      child:SizedBox(width: 20, height: 20, child: Theme.of(context).myIcons.inputPerson)
    ));

    return MyInput(
      controller: controller, 
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: Lang.inputAccountHintText.tr,
      onChanged: onChanged,
    );
  }

  /// 密码输入框
  static Widget password(BuildContext context, TextEditingController controller, FocusNode focusNode) {
    final showSuffixIcon = false.obs;
    final obscureText = true.obs;

    void onChanged(String text) {
      if (text.isEmpty) {
        showSuffixIcon.value = false;
      } else {
        showSuffixIcon.value = true;
      }
    }

    final showIcon = MyButton.icon(
      onPressed: () {
        obscureText.value = false;
        // if (!focusNode.hasFocus) focusNode.requestFocus();
      }, 
      icon: Theme.of(context).myIcons.inputShow,
    );

    final hideIcon = MyButton.icon(
      onPressed: () {
        obscureText.value = true;
        // if (!focusNode.hasFocus) focusNode.requestFocus();
      }, 
      icon: Theme.of(context).myIcons.inputHide,
    );

    

    final prefixIcon = SizedBox(width: 40, height: 40, child: Center(
      child:SizedBox(width: 20, height: 20, child: Theme.of(context).myIcons.inputPassword)
    ));

    return Obx(() => MyInput(
      obscureText: obscureText.value,
      controller: controller, 
      focusNode: focusNode,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: prefixIcon,
      suffixIcon: showSuffixIcon.value 
        ? obscureText.value ? showIcon : hideIcon
        : null,
      hintText: Lang.inputPasswordHintText.tr,
      onChanged: onChanged,
    ));
  }

  /// 图片验证码
  /// 点击验证码可以重新请求
  factory MyInput.pictureCode(
    BuildContext context, 
    TextEditingController controller, 
    FocusNode focusNode, 
    Rx<CaptchaModel> source,
  ) {
    final loading = false.obs;

    void onLoading() async {
      loading.value = true;
      // if (!focusNode.hasFocus) focusNode.requestFocus();
      source.value = await CaptchaModel.get(context);
      loading.value = false;
    }

    final prefixIcon = SizedBox(width: 40, height: 40, child: Center(
      child:SizedBox(width: 20, height: 20, child: Theme.of(context).myIcons.inputCode)
    ));

    final suffixIcon = Obx(() => MyButton.widget(
      onPressed: loading.value ? null : onLoading,
      child: loading.value
        ? MyCard(borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: Theme.of(context).myColors.onBackground.withOpacity(0.05),
            width: 100,
            height: 40,
            child: Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(
              strokeWidth: 2, color: Theme.of(context).myColors.primary,
            )))
          )
       : source.value.picPath.isNotEmpty
          ? Image.memory(base64Decode(source.value.picPath.split(',').last),
              height: 40,
              width: 100,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            )
          : MyButton.filedLong(
              textColor: Theme.of(context).myColors.primary,
              backgroundColor: Theme.of(context).myColors.onBackground.withOpacity(0.05),
              onPressed: onLoading, 
              text: Lang.inputCaptchaSendText.tr,
            )
      ));

    return MyInput(
      controller: controller, 
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: Lang.inputCaptchaHintText.tr,
    );
  }

  /// 手机号码
  /// 有手机验证码发送按钮
  factory MyInput.phone(TextEditingController controller, FocusNode focusNode) => MyInput(controller: controller, focusNode: focusNode);

  /// 手机验证码
  static Widget phoneCode(BuildContext context, TextEditingController controller, FocusNode focusNode) {
    return MyInput(controller: controller, focusNode: focusNode);
  }

  /// 金额输入框
  /// 有全部按钮
  factory MyInput.amount(TextEditingController controller, FocusNode focusNode) => MyInput(controller: controller, focusNode: focusNode);

  /// 金额范围输入框
  /// 有最小值 - 最大值
  factory MyInput.amountRange(TextEditingController controller, FocusNode focusNode) => MyInput(controller: controller, focusNode: focusNode);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      scrollPadding: EdgeInsets.zero,
      maxLength: maxLength,
      focusNode: focusNode,
      controller: controller,
      onSubmitted: (value) => Get.focusScope?.unfocus(),
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        fillColor: color,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: padding,
        hintText: hintText,
        hintStyle: Theme.of(context).myStyles.inputHint,
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Theme.of(context).myColors.primary,
            width: 0.8,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Theme.of(context).myColors.inputBorder,
            width: 0.8,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Theme.of(context).myColors.error,
            width: 0.8,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Theme.of(context).myColors.error,
            width: 0.8,
          ),
        ),
        errorText: errorText, // Error message text
        errorStyle: Theme.of(context).myStyles.inputErroeText,
      ),
      obscureText: obscureText,
      onTap: onTap,
      cursorColor: Theme.of(context).myColors.primary,
      cursorWidth: 1.6,
      style: Theme.of(context).myStyles.inputText,
      autofocus: autofocus,
      enabled: enabled,
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.center,
    );
  }
}