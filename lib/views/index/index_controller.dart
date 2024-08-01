import 'package:get/get.dart';

import '../../common/common.dart';
import 'index.dart';

class IndexController extends GetxController {
  final state = IndexState();

  final title = 'Index';
  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
    if (MyConfig.urls.baseUrl.isEmpty || MyConfig.urls.wsUrl.isEmpty) {
      // 没有拿到配置文件的逻辑
      // Get.dialog(
      //   Scaffold(
      //     body: Center(child: Container(width: 300, height: 300, color: Colors.red,),),
      //     backgroundColor: Colors.transparent,
      //   )
      // );
    } else {
      // 拿到了配置文件的逻辑
      // 这里是正常的逻辑
    }
  }
}
