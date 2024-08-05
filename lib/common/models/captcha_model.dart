import 'package:cgwallet/common/common.dart';

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

  Future<void> update() async {
    // 获取用户信息
    await DioService.to.get<CaptchaModel>(ApiPath.base.captcha,
      onSuccess: (code, msg, results) async {
        captchaId = results.captchaId;
        picPath = results.picPath;
        captchaLength = results.captchaLength;
        openCaptcha = results.openCaptcha;
      },
      onModel: (m) => CaptchaModel.fromJson(m),
    );
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
    captchaLength: -1,
    openCaptcha: false,
  );
}
