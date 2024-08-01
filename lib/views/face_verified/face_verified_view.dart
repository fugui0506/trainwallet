import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common.dart';
import 'index.dart';

class FaceVerifiedView extends GetView<FaceVerifiedController> {
  const FaceVerifiedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.normal(context: context, title: '人脸识别'),
      backgroundColor: Theme.of(context).myColors.background,
      body: Container(color: Colors.red),
    );
  }
}
