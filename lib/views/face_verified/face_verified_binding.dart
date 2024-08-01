import 'package:get/get.dart';

import 'index.dart';

class FaceVerifiedViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceVerifiedController>(() => FaceVerifiedController());
  }
}
