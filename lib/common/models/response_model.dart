// 返回数据格式化
class ResponseModel {
  ResponseModel({
    required this.code,
    required this.data,
    required this.msg,
  });

  int code;
  dynamic data;
  String msg;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    code: json["code"],
    data: json["data"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data,
    "msg": msg,
  };

  factory ResponseModel.err() => ResponseModel(
    code: -200,
    data: {},
    msg: 'msg',
  );
}
