import 'package:cgwallet/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class UnknownView extends GetView<UnknownController> {
  const UnknownView({super.key});

  @override
  Widget build(BuildContext context) {
    /// appbar
    var appBar = MyAppBar.normal(
      context: context,
      title: Lang.unknownViewTltle.tr,
    );

    /// 页面构成
    return Scaffold(appBar: appBar);
  }
}
