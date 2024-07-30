import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../common/common.dart';
import 'index.dart';

class WebviewView extends GetView<WebviewController> {
  const WebviewView({super.key});

  @override
  Widget build(BuildContext context) {
    /// appbar
    var appBar = MyAppBar.normal(
      context: context,
      title: Lang.webViewTltle.tr,
    );

    /// 页面构成
    return Scaffold(
      appBar: appBar,
      body: Obx(() => controller.state.isWebView 
        ? WebViewWidget(controller: controller.webController)
        : Container(color: Theme.of(context).myColors.onBackground)
      ),
    );
  }
}
