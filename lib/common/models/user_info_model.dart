class UserInfoModel {
  User user;
  String token;
  int expiresAt;
  // String ws;
  String balance;
  String frozenBalance;
  String lockBalance;
  String buyRate;
  String? walletAddress;

  UserInfoModel({
    required this.user,
    required this.token,
    required this.expiresAt,
    // required this.ws,
    required this.balance,
    required this.frozenBalance,
    required this.lockBalance,
    required this.buyRate,
    this.walletAddress,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    user: User.fromJson(json["user"]),
    token: json["token"],
    expiresAt: json["expiresAt"],
    // ws: json["ws"],
    balance: json["balance"],
    frozenBalance: json["frozenBalance"],
    lockBalance: json["lockBalance"],
    buyRate: json["buyRate"],
    walletAddress: json["walletAddress"],
  );

  factory UserInfoModel.empty() => UserInfoModel(
    user: User.empty(),
    token: '',
    expiresAt: 0,
    // ws: '',
    balance: '',
    frozenBalance: '',
    lockBalance: '',
    buyRate: '',
    walletAddress: '',
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
    "expiresAt": expiresAt,
    // "ws": ws,
    "balance": balance,
    "frozenBalance": frozenBalance,
    "lockBalance": lockBalance,
    "buyRate": buyRate,
    "walletAddress": walletAddress,
  };
}

class User {
  int id;
  int createdAt;
  int updatedAt;
  String createdTime;
  String updatedTime;
  int deletedAt;
  String username;
  String phone;
  String realName;
  String nickName;
  String avatarUrl;
  int enable;
  int isAuth;
  int lastTime;
  String lastAt;
  String lastIp;
  String totalBuyOrder;
  String totalSaleOrder;
  String totalSwap;
  int enableTransfer;
  String identityId;
  String identityFront;
  String identityBack;
  String registerDeviceNo;
  String loginDeviceNo;
  String riskMessage;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdTime,
    required this.updatedTime,
    required this.deletedAt,
    required this.username,
    required this.phone,
    required this.realName,
    required this.nickName,
    required this.avatarUrl,
    required this.enable,
    required this.isAuth,
    required this.lastTime,
    required this.lastAt,
    required this.lastIp,
    required this.totalBuyOrder,
    required this.totalSaleOrder,
    required this.totalSwap,
    required this.enableTransfer,
    required this.identityId,
    required this.identityFront,
    required this.identityBack,
    required this.registerDeviceNo,
    required this.loginDeviceNo,
    required this.riskMessage,
  });

  factory User.empty() => User(
    updatedAt: 0,
    deletedAt: 0,
    enable: 0,
    enableTransfer: 0,
    isAuth: 0,
    lastTime: 0,
    lastIp: '',
    totalBuyOrder: '',
    totalSaleOrder: '',
    totalSwap: '',
    createdAt: 0,
    createdTime: '',
    updatedTime: '',
    username: '',
    phone: '',
    realName: '',
    nickName: '',
    avatarUrl: '',
    identityId: '',
    identityFront: '',
    identityBack: '',
    registerDeviceNo: '',
    loginDeviceNo: '',
    riskMessage: '',
    id: 0,
    lastAt: '',
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["ID"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    createdTime: json["createdTime"],
    updatedTime: json["updatedTime"],
    deletedAt: json["deletedAt"],
    username: json["username"],
    phone: json["phone"],
    realName: json["realName"],
    nickName: json["nickName"],
    avatarUrl: json["avatarUrl"],
    enable: json["enable"],
    isAuth: json["isAuth"],
    lastTime: json["lastTime"],
    lastAt: json["lastAt"],
    lastIp: json["lastIP"],
    totalBuyOrder: json["totalBuyOrder"],
    totalSaleOrder: json["totalSaleOrder"],
    totalSwap: json["totalSwap"],
    enableTransfer: json["enableTransfer"],
    identityId: json["identityId"],
    identityFront: json["identityFront"],
    identityBack: json["identityBack"],
    registerDeviceNo: json["registerDeviceNo"],
    loginDeviceNo: json["loginDeviceNo"],
    riskMessage: json["riskMessage"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "createdTime": createdTime,
    "updatedTime": updatedTime,
    "deletedAt": deletedAt,
    "username": username,
    "phone": phone,
    "realName": realName,
    "nickName": nickName,
    "avatarUrl": avatarUrl,
    "enable": enable,
    "isAuth": isAuth,
    "lastTime": lastTime,
    "lastAt": lastAt,
    "lastIP": lastIp,
    "totalBuyOrder": totalBuyOrder,
    "totalSaleOrder": totalSaleOrder,
    "totalSwap": totalSwap,
    "enableTransfer": enableTransfer,
    "identityId": identityId,
    "identityFront": identityFront,
    "identityBack": identityBack,
    "registerDeviceNo": registerDeviceNo,
    "loginDeviceNo": loginDeviceNo,
    "riskMessage": riskMessage,
  };



  String maskPhoneNumber() {
    if (phone.length == 11) {
      String maskedNumber = phone.replaceRange(3, 7, '****');
      return maskedNumber;
    } else {
      return '137****9088';
    }
  }
}

class AvatarModel {
  final int id;
  final String avatarUrl;

  AvatarModel({
    required this.id,
    required this.avatarUrl,
  });

  factory AvatarModel.fromJson(Map<String, dynamic> json) => AvatarModel(
    id: json['id'],
    avatarUrl: json['avatar_url'],
  );

  factory AvatarModel.empty() => AvatarModel(id: 0, avatarUrl: '');
}
