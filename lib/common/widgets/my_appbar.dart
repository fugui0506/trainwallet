import 'package:flutter/material.dart';
import 'package:cgwallet/common/common.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double elevation;
  final ShapeBorder? shape;
  final TextTheme? textTheme;
  final bool centerTitle;
  final double? titleSpacing;
  final Color? backgroundColor;
  final Widget? flexibleSpace;
  final TextStyle? titleTextStyle;
  final IconThemeData? iconTheme;
  final PreferredSizeWidget? bottom;

  const MyAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.elevation = 0.0,
    this.shape,
    this.textTheme,
    this.centerTitle = true,
    this.titleSpacing,
    this.backgroundColor,
    this.flexibleSpace,
    this.iconTheme,
    this.titleTextStyle,
    this.bottom,
  });

  // 普通的 appbar
  factory MyAppBar.normal({
    required BuildContext context,
    required String title,
  }) => MyAppBar(
    backgroundColor: Theme.of(context).myColors.background,
    title: Text(title),
    titleTextStyle: Theme.of(context).myStyles.appBarTitle,
    iconTheme: Theme.of(context).myStyles.appBarIconThemeData,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).myColors.appBarGradientStart,
            Theme.of(context).myColors.appBarGradientEnd,
          ],
          stops: const [0.0, 1],
        ),
      ),
    ),
  );

  // 透明的
  factory MyAppBar.transparent({
    required BuildContext context,
    String? title,
    List<Widget>? actions,
  }) => MyAppBar(
    backgroundColor: Theme.of(context).myColors.background.withOpacity(0),
    title: title == null ? null : Text(title),
    actions: actions,
    titleTextStyle: Theme.of(context).myStyles.appBarTitle,
    iconTheme: Theme.of(context).myStyles.appBarIconThemeData,
  );

  // 首页的banner
  factory MyAppBar.spacer({
    Widget? title,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
  }) => MyAppBar(
    backgroundColor: Colors.transparent,
    title: title,
    titleSpacing: 0,
    flexibleSpace: flexibleSpace,
    bottom: bottom,
  );

  // scan 专用（白色）
  factory MyAppBar.white({
    required BuildContext context,
    required String title,
  }) {
    final whiteAppbarTitleTextStyle = TextStyle(
      color: Theme.of(context).myColors.onPrimary,
      fontSize: 18,
    );
    final whiteAppBarIconThemeData = IconThemeData(
      size: 18,
      color: Theme.of(context).myColors.onPrimary,
    );
    return MyAppBar(
      backgroundColor: Colors.transparent,
      title: Text(title),
      titleTextStyle: whiteAppbarTitleTextStyle,
      iconTheme: whiteAppBarIconThemeData,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? leadingButton;
    if (Navigator.canPop(context)) {
      leadingButton = IconButton(onPressed: () {
        Get.focusScope?.unfocus();
        Get.back();
      }, 
        icon: Container(color: Theme.of(context).myColors.primary.withOpacity(0), 
          width: double.infinity, 
          height: double.infinity, 
          child: const Center(child: Icon(Icons.arrow_back_ios),
        )),
      );
    }
    return AppBar(
      titleTextStyle: titleTextStyle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      iconTheme: iconTheme,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      flexibleSpace: flexibleSpace,
      leading: leading ?? leadingButton,
      title: title,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}