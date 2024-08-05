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
  MyAssets get loginRemberAccount => const MyAssets(name: 'single_checked', style: MyAssetStyle.svg);
  MyAssets get loginUnremberAccount => const MyAssets(name: 'single_uncheck', style: MyAssetStyle.svg);

  MyAssets get bottomChat0 => MyAssets(name: 'bottom_chat_0', style: MyAssetStyle.svg, color: myColors.textBottomUnselect,);
  MyAssets get bottomChat1 => const MyAssets(name: 'bottom_chat_1', style: MyAssetStyle.svg);
  MyAssets get bottomFlash0 => MyAssets(name: 'bottom_flash_0', style: MyAssetStyle.svg, color: myColors.textBottomUnselect,);
  MyAssets get bottomFlash1 => const MyAssets(name: 'bottom_flash_1', style: MyAssetStyle.svg);
  MyAssets get bottomHome0 => MyAssets(name: 'bottom_home_0', style: MyAssetStyle.svg, color: myColors.textBottomUnselect,);
  MyAssets get bottomHome1 => const MyAssets(name: 'bottom_home_1', style: MyAssetStyle.svg);
  MyAssets get bottomMine0 => MyAssets(name: 'bottom_mine_0', style: MyAssetStyle.svg, color: myColors.textBottomUnselect,);
  MyAssets get bottomMine1 => const MyAssets(name: 'bottom_mine_1', style: MyAssetStyle.svg);
  MyAssets get bottomScan => const MyAssets(name: 'bottom_scan', style: MyAssetStyle.svg);
  
  MyAssets get homeBuyCoin => const MyAssets(name: 'home_buy_coin', style: MyAssetStyle.svg);
  MyAssets get homeBuyOrders => const MyAssets(name: 'home_buy_orders', style: MyAssetStyle.svg);
  MyAssets get homeNewsIcon => const MyAssets(name: 'home_news_icon', style: MyAssetStyle.svg);
  MyAssets get homeNotice0 => const MyAssets(name: 'home_notice_0', style: MyAssetStyle.svg);
  MyAssets get homeNotice1 => const MyAssets(name: 'home_notice_1', style: MyAssetStyle.svg);
  MyAssets get homeQuickBuyButton => const MyAssets(name: 'home_quick_buy_button', style: MyAssetStyle.svg);
  MyAssets get homeSellCoin => const MyAssets(name: 'home_sell_coin', style: MyAssetStyle.svg);
  MyAssets get homeSellOrders => const MyAssets(name: 'home_sell_orders', style: MyAssetStyle.svg);
  MyAssets get homeTransfer => const MyAssets(name: 'home_transfer', style: MyAssetStyle.svg);
  MyAssets get homeCopy => const MyAssets(name: 'copy', style: MyAssetStyle.svg);
  MyAssets get homeAppBarBackground => const MyAssets(name: 'home_appbar_background', style: MyAssetStyle.png);
  MyAssets get homeWalletAddressBackground => const MyAssets(name: 'home_wallet_address_background', style: MyAssetStyle.svg, width: double.infinity, height: double.infinity,);

  MyAssets get helpHot => const MyAssets(name: 'help_hot', style: MyAssetStyle.svg);
  MyAssets get helpNormal => const MyAssets(name: 'help_normal', style: MyAssetStyle.svg);
  MyAssets get helpTitleIcon => const MyAssets(name: 'help_title_icon', style: MyAssetStyle.svg);

  MyAssets get logo => const MyAssets(name: 'logo', style: MyAssetStyle.svg);
  MyAssets get copyNormal => MyAssets(name: 'copy', style: MyAssetStyle.svg, color: myColors.iconCopy);
  MyAssets get customer => MyAssets(name: 'customer', style: MyAssetStyle.svg, color: myColors.iconDefault);
  MyAssets get qrcode => const MyAssets(name: 'qrcode', style: MyAssetStyle.svg);
  MyAssets get right => const MyAssets(name: 'right', style: MyAssetStyle.svg);

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