import 'package:cgwallet/common/common.dart';
import 'package:cgwallet/common/widgets/my_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaptchaModel {
  CaptchaModel({
    required this.captchaId,
    required this.picPath,
    required this.captchaLength,
    required this.openCaptcha,
  });

  String captchaId;
  String picPath;
  int captchaLength;
  bool openCaptcha;

  static Future<CaptchaModel> get(BuildContext context) async {
    var data = CaptchaModel.empty();
    MyAlert.loading(context);
    await DioService.to.get<CaptchaModel>(ApiPath.base.captcha,
      onSuccess: (code, msg, results) {
        data = results;
      },
      onModel: (m) => CaptchaModel.fromJson(m),
    );
    Get.back();
    return data;
  }

  factory CaptchaModel.fromJson(Map<String, dynamic> json) => CaptchaModel(
    captchaId: json["captchaId"],
    picPath: json["picPath"],
    captchaLength: json["captchaLength"],
    openCaptcha: json["openCaptcha"],
  );

  Map<String, dynamic> toJson() => {
    "captchaId": captchaId,
    "picPath": picPath,
    "captchaLength": captchaLength,
    "openCaptcha": openCaptcha,
  };

  factory CaptchaModel.empty() => CaptchaModel(
    captchaId: '',
    picPath: '',
    captchaLength: 0,
    openCaptcha: false,
  );
}
