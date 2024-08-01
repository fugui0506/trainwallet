import 'package:cgwallet/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class FlashExchangeView extends GetView<FlashExchangeController> {
  const FlashExchangeView({super.key});

  @override
  Widget build(BuildContext context) {
    /// appbar
    var appBar = MyAppBar.normal(
      context: context,
      title: 'Lang.FlashExchangeViewTltle.tr',
    );

    /// 页面构成
    return Scaffold(appBar: appBar);
  }
}
