import 'package:get/get.dart';
import '../../common/common.dart';
import 'index.dart';

class CustomerController extends GetxController {
  final state = CustomerState();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
  }
}
