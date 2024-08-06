import 'package:cgwallet/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlert {
  static void snackbar(String message) {
    if (Get.isSnackbarOpen) return;
    final messageBox = Center(child: MyCard.snackbar(
      Text(message, style: Get.theme.myStyles.onSnackbar, textAlign: TextAlign.center),
    ));
    Get.rawSnackbar(
      messageText: messageBox,
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 2000),
      backgroundColor: Colors.transparent,
    );
  }

  static void loading(BuildContext context) {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) return;
    final loadingBox = Center(child: SizedBox(width: 20, height: 20, child: CupertinoActivityIndicator(color: Theme.of(context).myColors.onPrimary, radius: 14)));
    final child = Center(child: MyCard.loading(context, loadingBox));
    Get.dialog(child, barrierDismissible: false, useSafeArea: false);
  }

  static void block() {
    final child = Container();
    Get.dialog(child, barrierDismissible: false, useSafeArea: false, barrierColor: Colors.transparent);
  }

  static void dialog({
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    void Function()? onConfirm,
    void Function()? onCancel,
    bool showCancelButton = true,
    bool showConfirmButton = true,
  }) {
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
                if (title != null)
                  Text(title, style: Theme.of(context).myStyles.appBarTitle),
                if (title != null)
                  const SizedBox(height: 20),
                if (message != null)
                  Text(message, style: Theme.of(context).myStyles.content,),
                if (message != null)
                  const SizedBox(height: 20),
                if (showCancelButton || showConfirmButton)
                  (showCancelButton && !showConfirmButton) || (!showCancelButton && showConfirmButton)
                    ? MyButton.filedLong(
                        onPressed: () {
                          Get.back();
                          showCancelButton ? onCancel?.call() : onConfirm?.call();
                        }, 
                        text: showCancelButton ? cancelText ?? '确认' : confirmText ?? '确认', 
                        textColor: Theme.of(context).myColors.onPrimary,
                      )
                    : Row(children: [
                        Expanded(child: MyButton.filedLong(
                          onPressed: () {
                            Get.back();
                            onCancel?.call();
                          }, 
                          text: cancelText ?? '取消', 
                          backgroundColor: Theme.of(context).myColors.buttonDisable,
                          textColor: Theme.of(context).myColors.onBackground,
                        )),
                        const SizedBox(width: 10),
                        Expanded(child: MyButton.filedLong(
                          onPressed: () {
                            Get.back();
                            onConfirm?.call();
                          }, 
                          text: confirmText ?? '确认', 
                          textColor: Theme.of(context).myColors.onPrimary
                        )),
                      ]),
              ],
            ),
          ),
        );
      },
    );
  }
}