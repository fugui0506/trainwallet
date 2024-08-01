import 'package:get/get.dart';
import '../../../common/common.dart';
import 'index.dart';

class MineController extends GetxController {
  final state = MineState();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
  }
}
