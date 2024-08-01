part of 'theme.dart';

class MyStyles {
  MyStyles({required this.myColors});
  final MyColors myColors;

  // 输入框的 hintText 样式
  TextStyle get inputHint => TextStyle(color: myColors.inputHint, fontSize: 14);
  // 输入框文本的样式
  TextStyle get inputText => TextStyle(color: myColors.inputText, fontSize: 14);
  // 输入框文本的样式
  TextStyle get inputErroeText => TextStyle(color: myColors.error, fontSize: 14);

  // 登录页面Title
  TextStyle get loginTitleSelect => TextStyle(color: myColors.primary, fontSize: 16);
  TextStyle get loginPasswordTitle => TextStyle(color: myColors.primary, fontSize: 18);
  TextStyle get loginTitleUnselect => TextStyle(color: myColors.primary, fontSize: 16);

  // 高度是0的Label样式
  TextStyle get labelText => TextStyle(color: myColors.textDefault, fontSize: 14, height: 0);

  // appBar的文字样式
  TextStyle get appBarTitle => TextStyle(color: myColors.onaAppBar, fontSize: 18);
  // appBar的图标样式
  IconThemeData get appBarIconThemeData => IconThemeData(color: myColors.onaAppBar, size: 18);

  // appBar的文字样式
  TextStyle get dialogTitle => TextStyle(color: myColors.onDialogBackground, fontSize: 18);
  // appBar的图标样式
  IconThemeData get dialogMessage => IconThemeData(color: myColors.onDialogBackground, size: 14);

  // snackBar 文字样式
  TextStyle get onSnackbar => TextStyle(color: myColors.background, fontSize: 14);

  // 按钮文字的样式
  TextStyle get buttonText => const TextStyle(fontSize: 14);

  // 底部导航栏的文字样式
  TextStyle get bottomSelect => TextStyle(fontSize: 12, color: myColors.primary, height: 0);
  TextStyle get bottomUnselect => TextStyle(fontSize: 12, color: myColors.textBottomUnselect, height: 0);

  // 长按钮的样式
  ButtonStyle getButtonFilledLong({Color? textColor, Color? buttonColor, double? radius}) => ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle?>(buttonText),
    backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) return myColors.buttonPressed;
      if (states.contains(MaterialState.disabled)) return myColors.buttonDisable;
      return buttonColor ?? myColors.primary;
    }),
    foregroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) return myColors.onPrimary;
      if (states.contains(MaterialState.disabled)) return myColors.onButtonDisable;
      return textColor ?? myColors.onPrimary;
    }),
    minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 40)),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
    ),
  );

  // 短按钮的样式
  ButtonStyle getButtonFilledShort({Color? textColor, Color? buttonColor, double? radius}) => ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle?>(buttonText),
    backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) return myColors.buttonPressed;
      if (states.contains(MaterialState.disabled)) return myColors.buttonDisable;
      return buttonColor ?? myColors.primary;
    }),
    foregroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) return myColors.onButtonDisable;
      return textColor ?? myColors.onPrimary;
    }),
    shape: MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),),
  );

  // 文字按钮的样式
  ButtonStyle getButtonText({Color? textColor, double? fontSize, double? radius}) => TextButton.styleFrom(
    textStyle: TextStyle(
      fontSize: fontSize ?? 14,
      height: 0
    ),
    foregroundColor: textColor ?? myColors.onBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),
  );
}
