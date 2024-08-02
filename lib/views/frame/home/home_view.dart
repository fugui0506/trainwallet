import 'package:cgwallet/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    /// appbar
    var appBar = MyAppBar.normal(
      context: context,
      title: 'Lang.HomeViewTltle.tr',
    );

    /// 页面构成
    return Scaffold(
      appBar: appBar, body: SingleChildScrollView(child: Column(children: [
      MyInput.account(context, TextEditingController(), FocusNode()),
      Container(color: Colors.green, height: 300,),
      Container(color: Colors.red, height: 300,),
      Container(color: Colors.white, height: 300,),
    ],),),);
  }
}
