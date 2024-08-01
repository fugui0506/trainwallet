import 'package:get/get.dart';
import '../../common/common.dart';
import 'index.dart';

class FrameController extends GetxController {
  final state = FrameState();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
  }

  void onChanged(int index) {
    if (index == 4) {
      goScanView();
    } else {
      state.pageIndex = index;
    }
  }

  void goScanView() {
    Get.toNamed(MyRoutes.scanView);
  }
}
