import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../common/common.dart';
import 'index.dart';

class ScanController extends GetxController {
  final state = ScanState();
  final MobileScannerController mobileScannerController = MobileScannerController();


  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
  }

  @override
  void onClose() {
    mobileScannerController.dispose();
    super.onClose();
  }

  void onDetect(BarcodeCapture barcodeCapture) async {
    if (barcodeCapture.barcodes.first.displayValue != null) {
      MyLogger.w(barcodeCapture.barcodes.first.displayValue);
      Get.back();
      await Future.delayed(MyConfig.app.timePageTransition);
      MyAlert.snackbar('${Lang.scanViewResult.tr} ${barcodeCapture.barcodes.first.displayValue}');
    }
  }

  void onScan(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      return;
    }

    final BarcodeCapture? barcodeCapture = await mobileScannerController.analyzeImage(
      image.path,
    );

    if (!context.mounted) {
      return;
    }

    if (barcodeCapture != null) {
      onDetect(barcodeCapture);
    } else {
      MyAlert.snackbar(Lang.scanViewMessage.tr);
    }
  }
}
