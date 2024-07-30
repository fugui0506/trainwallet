part of 'config.dart';

class _App {
  // 密码加盐
  final String aesKey = '96ac58d7a2efba1f416d2489f9bde583';
  // 网易易盾人脸识别业务ID
  final String faceId = '52b16b0cdf8b4154aca8b2fe894b5ca7';
  // 网易易盾行为验证码
  final String captchaKey = 'd5c288353d414d7a8c277de23430de64';
  
  // 请求超时时间
  final Duration timeOut = const Duration(seconds: 30);
  // 等待时间
  final Duration timeWait = const Duration(seconds: 2);
  // 心跳间隔
  final Duration timeHeartbeat = const Duration(seconds: 10);
  // 重连间隔的基数
  final Duration timeRetry = const Duration(seconds: 5);
  // 页面切换动画时长
  final Duration timePage = const Duration(milliseconds: 300);

  // 最大重连次数
  final int maxRetryAttempts = 7;
  
  // 原生通道
  final String channelDeviceInfo = 'com.example.cgwallet/device_info';
  final String channelImage = 'com.example.cgwallet/image';

}