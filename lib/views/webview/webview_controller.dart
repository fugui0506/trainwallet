// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:cgwallet/common/config/config.dart';
import 'package:cgwallet/common/utils/utils.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'index.dart';

class WebviewController extends GetxController {
  final state = WebviewState();

  // InAppWebViewController? webController;
  late final WebViewController webController;
  final url = Uri.parse('https://walletqiliao.z13a70.com/?cert=CIQCEAUYASCSAiiBxpu5_jE.62R3StIjnJfeyPi8Svz9YldyjW5EBcxtcvwDrupyc-MsAs1IA6PAzlybxJGvdvKj6lZk18vgvm2t7EQFGggeDQ"');

  @override
  onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePage);
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate( NavigationDelegate(
        onPageStarted: (String url) async {
          await runJavaScript();
        },
        onPageFinished: (String url) async {
          state.isWebView = true;
        },
        onHttpError: (HttpResponseError error) {
          MyLogger.w(error);
        },
        onWebResourceError: (WebResourceError error) {
          MyLogger.w(error);
        },
      ))
    ..loadRequest(url);
  }

  Future<void> runJavaScript() async {
    await webController.runJavaScript("""
      console.log("Checking replaceAll polyfill at onLoadStart");
      if (!String.prototype.replaceAll) {
        String.prototype.replaceAll = function(str, newStr) {
          if (typeof str === 'string' && typeof newStr === 'string') {
            return this.replace(new RegExp(str.replace(/[.*+?^\${}()|[\\]\\\\]/g, '\\\\\$&'), 'g'), newStr);
          } else {
            console.error('Invalid arguments for replaceAll');
            return this;
          }
        };
        console.log("replaceAll polyfill injected at onLoadStart");
      } else {
        console.log("replaceAll already exists at onLoadStart");
      }
    """);
  }
}
