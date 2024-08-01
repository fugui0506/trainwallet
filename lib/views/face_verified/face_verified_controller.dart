
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/common.dart';
import 'index.dart';

class FaceVerifiedController extends GetxController {
  final state = FaceVerifiedState();
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();

  final idController = TextEditingController();
  final idFocusNode = FocusNode();

  final pageController = PageController();

  final ImagePicker picker = ImagePicker();




  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePage);
  }
}
