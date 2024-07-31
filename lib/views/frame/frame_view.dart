import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:camera/camera.dart';

import '../../common/common.dart';
import 'index.dart';

class FrameView extends GetView<FrameController> {
  const FrameView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).myColors.background,
    );
  }
}