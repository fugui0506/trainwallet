import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:camera/camera.dart';

import '../../common/common.dart';
import 'index.dart';

class ScanView extends GetView<ScanController> {
  const ScanView({super.key});


  @override
  Widget build(BuildContext context) {
    final mobileScanner = MobileScanner(
      controller: controller.mobileScannerController,
      onDetect: controller.onDetect,
    );

    final marker = Positioned.fill(
      child: CustomPaint(
        painter: HollowPainter(),
      ),
    );

    final buttons = Column(
      children: [
        const Spacer(),
        SafeArea(child: MyButton.filedLong(onPressed: () => controller.onScan(context), text: '相册'))
      ],
    );

    return Scaffold(
      appBar: MyAppBar.white(context: context, title: Lang.scanViewTltle.tr),
      backgroundColor: Theme.of(context).myColors.background,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(children: [mobileScanner, marker, buttons]),
    );
  }
}

class HollowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    const double radius = 16;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(centerX, centerY), width: centerX, height: centerX),
          const Radius.circular(radius)));

    // 创建蒙版效果，半透明黑色
    final maskPaint = Paint()..color = Colors.black.withOpacity(0.8);

    // 应用蒙版效果
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), maskPaint);

    // 绘制整个区域
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), maskPaint);

    // 清除镂空区域的蒙版效果
    canvas.drawPath(path, Paint()..blendMode = BlendMode.clear);

    // 恢复画布
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}