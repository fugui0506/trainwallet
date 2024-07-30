import 'package:cgwallet/common/common.dart';
import 'package:cgwallet/common/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlert {
  static void snackbar(String message) {
    if (Get.isSnackbarOpen) return;
    Get.rawSnackbar(
      messageText: Text(message, style: Get.theme.myStyles.onSnackbar),
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 2000),
      boxShadows: [BoxShadow(color: Get.theme.myColors.primary, blurRadius: 13,)],
      backgroundColor: Get.theme.myColors.background.withOpacity(0.9)
    );
  }

  static void loading(BuildContext context) {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) return;
    const loadingBox = Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(
      color: Colors.white,
      strokeWidth: 2,
    )));
    final child = Center(child: MyCard.loading(context, loadingBox));
    Get.dialog(child, barrierDismissible: false);
  }

  static void dialog(String message) {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) return;
    Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const  Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Custom Dialog Title', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                const Text('This is a custom dialog content.'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // 关闭对话框
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}