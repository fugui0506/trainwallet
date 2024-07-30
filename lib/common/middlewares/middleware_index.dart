import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../common.dart';

/// 第一次欢迎页面
class MiddlewareIndex extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return const RouteSettings(name: MyRoutes.loginView);
  }
}
