import 'package:get/get.dart';

class FrameState {
  final _isCameraPreview = false.obs;
  bool get isCameraPreview => _isCameraPreview.value;
  set isCameraPreview(bool value) => _isCameraPreview.value = value;
}
