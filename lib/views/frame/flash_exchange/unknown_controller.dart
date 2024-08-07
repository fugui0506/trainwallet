import 'package:get/get.dart';
import '../../../common/common.dart';
import 'index.dart';

class FlashExchangeController extends GetxController {
  final state = FlashExchangeState();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
  }
}
