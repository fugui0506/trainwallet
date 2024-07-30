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
    await Future.delayed(MyConfig.app.timePage);
  }

  @override
  void onClose() {
    mobileScannerController.dispose();
    super.onClose();
  }

  void onDetect(BarcodeCapture barcodeCapture) {
    if (barcodeCapture.barcodes.first.displayValue != null) {
      MyLogger.w(barcodeCapture.barcodes.first.displayValue);
      Get.back(result: barcodeCapture.barcodes.first.displayValue);
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

    final BarcodeCapture? barcodes = await mobileScannerController.analyzeImage(
      image.path,
    );

    if (!context.mounted) {
      return;
    }


    final SnackBar snackbar = barcodes != null
        ? SnackBar(
            content: Text('Barcode found! --> ${barcodes.barcodes.first.displayValue}'),
            backgroundColor: Colors.green,
          )
        : const SnackBar(
            content: Text('No barcode found!'),
            backgroundColor: Colors.red,
          );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
