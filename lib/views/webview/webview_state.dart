import 'package:cgwallet/common/common.dart';
import 'package:get/get.dart';

class WebviewState {
  final _isWebView = false.obs;
  bool get isWebView => _isWebView.value;
  set isWebView(bool value) => _isWebView.value = value;

  String url = 'https://wwww.baidu.com';
  String title = Lang.webViewTltle.tr;
}
