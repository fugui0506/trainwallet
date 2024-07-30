import 'package:get/get.dart';

class WebviewState {
  final _isWebView = false.obs;
  bool get isWebView => _isWebView.value;
  set isWebView(bool value) => _isWebView.value = value;
}
