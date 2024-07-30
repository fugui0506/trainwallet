import 'dart:ui';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../common.dart';

part 'lang_keys.dart';
part "key_en.dart";
part 'key_zh.dart';

class MyLang extends Translations {
  static const defaultLocale = Locale('zh', 'Hans_CN');
  static const fallbackLocale = Locale('zh', 'Hans_CN');

  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const supportedLocales = [
    Locale('zh', 'Hans_CN'), // 中文简体
    Locale('en', 'US'), // 美国英语
  ];

  final _keys = {
    'zh_Hans_CN': zh,
    'en_US': en,
  };

  @override
  Map<String, Map<String, String>> get keys => _keys;

  /// 更改语言
  static Future<void> updateLocale(String localeString, bool save) async {

    late Locale locale;
    switch (localeString) {
      case 'zh_Hans_CN' || 'zh_CN':
        locale = const Locale('zh', 'Hans_CN');
        DeviceService.to.locale.value = locale;
        break;
      case 'en_US':
        locale = const Locale('en', 'US');
        DeviceService.to.locale.value = locale;
        break;
      default:
        locale = defaultLocale;
        DeviceService.to.locale.value = locale;
        break;
    }
    await Get.updateLocale(locale);
    if (save) await SharedService.to.setString(MyConfig.shard.localKey, localeString);
    MyLogger.w('当前APP语言：${Get.locale}');
    MyLogger.w('当前系统语言：${Get.deviceLocale}', isNewline: false);
    MyLogger.w('当前语言模式：${SharedService.to.getString(MyConfig.shard.localKey).isEmpty ? '系统' : localeString }', isNewline: false);
  }

  static Future<void> systemLocale() async {
    DeviceService.to.locale.value = Get.deviceLocale ?? defaultLocale;
    await updateLocale('${DeviceService.to.locale.value}', false);
    await SharedService.to.remove(MyConfig.shard.localKey);
  }

  // 设置语言
  static Future<void> initLocale() async {
    String localeString = SharedService.to.getString(MyConfig.shard.localKey);
    if (localeString.isEmpty) {
      DeviceService.to.locale.value = Get.deviceLocale ?? defaultLocale;
      await updateLocale('${DeviceService.to.locale.value}', false);
    } else {
      await updateLocale(localeString, false);
    }
  }
}
