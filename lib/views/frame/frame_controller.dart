import 'package:get/get.dart';
import '../../common/common.dart';
import 'index.dart';

class FrameController extends GetxController {
  final state = FrameState();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePage);
  }
}
