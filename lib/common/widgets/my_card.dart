import 'package:cgwallet/common/common.dart';
import 'package:flutter/material.dart';

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
  });

  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;


  factory MyCard.login(BuildContext context, Widget child) => MyCard(
    color: Theme.of(context).myColors.cardBackground,
    width: double.infinity,
    borderRadius: BorderRadius.circular(20),
    margin: const EdgeInsets.all(20),
    child: child,
  );

  factory MyCard.loading(BuildContext context, Widget child) => MyCard(
    color: Theme.of(context).myColors.primary,
    width: 60,
    height: 60,
    borderRadius: BorderRadius.circular(10),
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
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}