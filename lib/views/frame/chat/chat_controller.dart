import 'package:get/get.dart';
import '../../../common/common.dart';
import 'index.dart';

class ChatController extends GetxController {
  final state = ChatState();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
  }
}
