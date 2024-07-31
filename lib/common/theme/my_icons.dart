part of 'theme.dart';
class MyIcons {
  MyIcons({required this.myColors});
  final MyColors myColors;

  MyAssets get inputCode => MyAssets(name: 'input_code', style: MyAssetStyle.svg, color: myColors.inputPrefixIcon);
  MyAssets get inputFundPassword => MyAssets(name: 'input_fund_password', style: MyAssetStyle.svg, color: myColors.inputPrefixIcon);
  MyAssets get inputHide => MyAssets(name: 'input_hide', style: MyAssetStyle.svg, color: myColors.inputSuffixIcon);
  MyAssets get inputPassword => MyAssets(name: 'input_password', style: MyAssetStyle.svg, color: myColors.inputPrefixIcon);
  MyAssets get inputPerson => MyAssets(name: 'input_person', style: MyAssetStyle.svg, color: myColors.inputPrefixIcon);
  MyAssets get inputPhoneCode => MyAssets(name: 'input_phone_code', style: MyAssetStyle.svg, color: myColors.inputPrefixIcon);
  MyAssets get inputPhone => MyAssets(name: 'input_phone', style: MyAssetStyle.svg, color: myColors.inputPrefixIcon);
  MyAssets get inputShow => MyAssets(name: 'input_show', style: MyAssetStyle.svg, color: myColors.inputSuffixIcon);
  MyAssets get inputClear => MyAssets(name: 'input_clear', style: MyAssetStyle.svg, color: myColors.inputSuffixIcon);

  MyAssets get loginTitleBackgroundLeft => const MyAssets(name: 'login_title_background_left', style: MyAssetStyle.svg);
  MyAssets get loginTitleBackgroundRight => const MyAssets(name: 'login_title_background_right', style: MyAssetStyle.svg);
  MyAssets get loginTitleSelect => MyAssets(name: '${Get.isDarkMode ? 'dark' : 'light'}/login_title_select', style: MyAssetStyle.png, width: 60,);

  MyAssets get singleChecked => const MyAssets(name: 'single_checked', style: MyAssetStyle.svg);
  MyAssets get singleUncheck => const MyAssets(name: 'single_uncheck', style: MyAssetStyle.svg);

  MyAssets get logo => const MyAssets(name: 'logo', style: MyAssetStyle.svg);
  MyAssets get customer => MyAssets(name: 'customer', style: MyAssetStyle.svg, color: myColors.iconDefault,);


  Widget loading({double? width, double? height, double? radius, EdgeInsetsGeometry? margin}) {
    if (radius == null && margin == null) return const MyAssets(name: 'loading', style: MyAssetStyle.lottie);
    return Container(width: width, height: height, margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: const MyAssets(name: 'loading', style: MyAssetStyle.lottie),
    );
  }
}