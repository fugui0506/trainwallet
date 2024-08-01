import 'package:get/get.dart';

class FaceVerifiedState {
  final pageIndex = 0.obs;

  // 第 1 位是正面，''代表无数据
  // 第 2 位是反面，''代表无数据
  final idCard = ['', ''].obs;
  // 正面的图片地址，上传后才能拿到
  // String frontPicUrl = '';
  // 背面的图片地址，上传后才能拿到
  // String backPicUrl = '';

  // 输入框的右边距
  // 这里是因为视觉上的纠正，所以需要这个值
  final namePaddingRight = 20.0.obs;
  final idPaddingRight = 20.0.obs;

  // 按钮是否禁用
  final _isButtonDisable = true.obs;
  set isButtonDisable(bool value) => _isButtonDisable.value = value;
  bool get isButtonDisable => _isButtonDisable.value;

  // 上传按钮是否禁用
  // 点击了提交以后，禁止再更改照片
  final _isLoadDisable = false.obs;
  set isLoadDisable(bool value) => _isLoadDisable.value = value;
  bool get isLoadDisable => _isLoadDisable.value;

  // 认证结果
  // 是否通过
  final _isVerifiedPass = false.obs;
  set isVerifiedPass(bool value) => _isVerifiedPass.value = value;
  bool get isVerifiedPass => _isVerifiedPass.value;
}
