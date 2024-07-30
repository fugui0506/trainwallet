class MyTimer {
  /// 时间格式化
  /// 把秒数转成：00:00:00的格式
  static String getDuration(int seconds) {
    // 初始化
    // 首先默认所有的时间都是 0
    String s = '';
    String m = '';
    String h = '';

    if (seconds % 60 < 10) {
      s = '0${seconds % 60}';
    } else {
      s = '${seconds % 60}';
    }

    if (seconds ~/ 60 % 60 < 10) {
      m = '0${seconds ~/ 60 % 60}';
    } else {
      m = '${seconds ~/ 60 % 60}';
    }

    if (seconds ~/ 3600 < 10) {
      h = '0${seconds ~/ 3600}';
    } else {
      h = '${seconds ~/ 3600}';
    }

    return seconds ~/ 3600 > 0 ? '$h:$m:$s' : '$m:$s';
  }
}
