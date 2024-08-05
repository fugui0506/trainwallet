import 'package:cgwallet/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMarqueeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final index = 0.obs;
  final constraintsWidth = 0.0.obs;
  final textWidth= 0.0.obs;
  final text = ''.obs;
  final length = 0.obs;

  double getTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  void move() {
    final seconds = constraintsWidth * 4 ~/ 360;
    // 平滑地滚动到视图的结束位置
    scrollController.animateTo(
      constraintsWidth.value,
      duration: Duration(seconds: seconds), // 动画持续时间
      curve: Curves.linear, // 动画曲线
    ).then((value) => onDone());
  }

  void onDone() {
    scrollController.jumpTo(0.0);
    index.value = (index.value + 1) % length.value;
    update();
    move();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    move();
  }
}

class MyMarquee extends GetView<MyMarqueeController> {
  const MyMarquee({super.key, required this.marqueeList});

  final MarqueeListModel marqueeList;
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyMarqueeController(),
      builder: (controller) => _builder(context, controller)
    );
  }

  Widget _builder(BuildContext context, MyMarqueeController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = Theme.of(context).myStyles.label;
        controller.length.value = marqueeList.list.length;
        controller.text.value = marqueeList.list[controller.index.value].content;
        final textWidth = controller.getTextWidth(marqueeList.list[controller.index.value].content, textStyle);
        controller.textWidth.value = textWidth;
        controller.constraintsWidth.value = constraints.maxWidth * 2 + textWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: controller.scrollController,
          child: Row(
            children: [
              SizedBox(width: constraints.maxWidth),
              Text(marqueeList.list[controller.index.value].content, maxLines: 1, style: textStyle, textDirection: TextDirection.ltr),
              SizedBox(width: constraints.maxWidth),
            ],
          ),
        );
      },
    );
  }
}