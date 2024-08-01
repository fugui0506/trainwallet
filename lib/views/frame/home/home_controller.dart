import 'package:get/get.dart';
import '../../../common/common.dart';
import 'index.dart';

class HomeController extends GetxController {
  final state = HomeState();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
  }
}
