import 'package:get/get.dart';
import '../../common/common.dart';
import 'index.dart';

class UnknownController extends GetxController {
  final state = UnknownState();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
  }
}
