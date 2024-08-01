import 'package:get/get.dart';

import '../../views/views.dart';
import '../common.dart';

class MyPages {
  // 未知页面
  static final unknownRoute = GetPage(
    name: MyRoutes.unknownView,
    page: () => const UnknownView(),
    binding: UnknownBinding(),
  );

  static final List<GetPage> getPages = [
    // 初始页面
    GetPage(
      name: MyRoutes.indexView,
      page: () => const IndexView(),
      binding: IndexBinding(),
      // middlewares: [
      //   MiddlewareIndex(),
      // ],
    ),

    // 登录页面框架
    GetPage(
      name: MyRoutes.loginView,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    // webview
    GetPage(
      name: MyRoutes.webView,
      page: () => const WebviewView(),
      binding: WebviewBinding(),
    ),

    // 扫码
    GetPage(
      name: MyRoutes.scanView,
      page: () => const ScanView(),
      binding: ScanBinding(),
    ),

    // 主界面
    GetPage(
      name: MyRoutes.frameView,
      page: () => const FrameView(),
      binding: FrameBinding(),
    ),

    // 人脸识别
    GetPage(
      name: MyRoutes.faceVerifiedView,
      page: () => const FaceVerifiedView(),
      binding: FaceVerifiedViewBinding(),
    ),
  ];
}
