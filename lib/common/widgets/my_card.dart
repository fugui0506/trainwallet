import 'package:cgwallet/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    this.color,
    this.borderRadius,
    this.width,
    this.height,
    this.child,
    this.padding,
    this.margin,
    this.boxShadow,
    this.border,
  });

  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;

  factory MyCard.login({required BuildContext context, Widget? child}) => MyCard(
    color: Theme.of(context).myColors.cardBackground,
    width: double.infinity,
    borderRadius: BorderRadius.circular(20),
    margin: const EdgeInsets.all(20),
    child: child,
  );

  factory MyCard.loading({required BuildContext context, Widget? child}) => MyCard(
    color: Theme.of(context).myColors.primary,
    width: 60,
    height: 60,
    borderRadius: BorderRadius.circular(10),
    child: child,
  );

  factory MyCard.snackbar(String message) => MyCard(
    color: Get.theme.myColors.onBackground.withOpacity(0.72),
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    borderRadius: BorderRadius.circular(8),
    child: Text(message, style: Get.theme.myStyles.onSnackbar, textAlign: TextAlign.center),
  );

  factory MyCard.avatar({required BuildContext context, required double radius, Widget? child, Color? color}) => MyCard(
    color: color ?? Theme.of(context).myColors.buttonDisable,
    width: radius * 2,
    height: radius * 2,
    borderRadius: BorderRadius.circular(radius),
    child: child,
  );

  factory MyCard.carousel({required BuildContext context, Widget? child}) => MyCard(
    color: Theme.of(context).myColors.cardBackground,
    width: double.infinity,
    height: (Get.width - 32) * 120 / 360,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(width: 1, color: Colors.white),
    boxShadow: [BoxShadow(blurRadius: 8,color: Colors.black.withOpacity(0.08))], 
    child: child,
  );

  factory MyCard.normal({required BuildContext context, Widget? child, EdgeInsetsGeometry? padding}) => MyCard(
    color: Theme.of(context).myColors.cardBackground,
    borderRadius: BorderRadius.circular(10),
    padding: padding,
    child: child,
  );

  factory MyCard.faq({required BuildContext context, Widget? child, EdgeInsetsGeometry? padding, EdgeInsetsGeometry? margin,}) => MyCard(
    color: Theme.of(context).myColors.faqBackground,
    borderRadius: BorderRadius.circular(10),
    padding: padding,
    margin: margin,
    child: child,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        shape: BoxShape.rectangle,
        boxShadow: boxShadow,
        border: border,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}