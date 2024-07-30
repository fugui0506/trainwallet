part of 'theme.dart';

class MyColors {
  // 主色-固定色
  Color get primary => const Color(0xFF586BF9);
  // 主色上面的颜色
  Color get onPrimary => const Color(0xFFFFFFFF);
  // 背景色 / 主题色
  Color get background => Get.isDarkMode ? const Color(0xFF333334) : const Color(0xFFF5F8FC);
  // 背景上的反色，例如文字
  Color get onBackground => Get.isDarkMode ? const Color(0xFFF5F8FC) : const Color(0xFF333334);
  // 错误的颜色
  Color get error => const Color(0xFFDF0000);
  // 错误颜色上面的颜色
  Color get onError => const Color(0xFFFFFFFF);

  // 卡片背景颜色
  Color get cardBackground => Get.isDarkMode ? const Color(0xFF1F1F20) : const Color(0xFFFFFFFF);
  // 卡片上的文字颜色
  Color get onCardBackground => Get.isDarkMode ? const Color(0xFFF5F8FC) : const Color(0xFF333334);

  
  // 输入框边框的颜色
  Color get inputBorder => Get.isDarkMode ? const Color(0xFF434345) : const Color(0xFFD1D1D1);
  // 输入框左侧图标的颜色
  Color get inputPrefixIcon => Get.isDarkMode ? const Color(0xFFF5F8FC) : const Color(0xFF333334);
  // 输入框左侧图标的颜色
  Color get inputSuffixIcon => Get.isDarkMode ? const Color(0xFF8E8E92) : const Color(0xFFD1D1D1);
  // 输入框文字颜色
  Color get inputText => Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  // 输入框提示文本颜色
  Color get inputHint => Get.isDarkMode ? const Color(0xFF8E8E92) : const Color(0xFFD1D1D1);

  // 文本颜色
  Color get textDefault => Get.isDarkMode ? const Color(0xFFD1D1D1) : const Color(0xFF666666);

  // 按钮禁用的背景颜色
  Color get buttonDisable => Get.isDarkMode ? const Color(0xFF434345) : const Color(0xFFD1D1D1);
  // 按钮禁用状态下的文字颜色
  Color get onButtonDisable => Get.isDarkMode ? const Color(0xFFA8A8A8) : const Color(0xFFFFFFFF);
  // 按钮按下时的背景颜色
  Color get buttonPressed =>  const Color(0xFF7800F8);
  // 按钮按下时，按钮上面的颜色
  Color get onButtonPressed =>  const Color(0xFFFFFFFF);

  // appBar 背景渐变色 - 起始位置
  Color get appBarGradientStart => Get.isDarkMode ? const Color(0xFF3A3A4B) : const Color(0xFFD7E2FF);
  // appBar 背景渐变色 - 终止位置
  Color get appBarGradientEnd => Get.isDarkMode ? const Color(0xFF333334) : const Color(0xFFF5F8FC);
  // appBar 上面的文字颜色
  Color get onaAppBar => Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF000000);


  // snackbar 背景色
  Color get snackbarBacground => Get.isDarkMode ? const Color(0xFF1B1B1E) : const Color(0xFFFFFFFF);
  // appBar 背景渐变色 - 终止位置
  Color get onSnackbarBacground => Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF333334);

}
