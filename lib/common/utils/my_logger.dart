import 'dart:convert';
import 'dart:developer';

import 'package:cgwallet/common/models/models.dart';
import 'package:dio/dio.dart';

/// 日志格式化
class MyLogger {
  static void w(dynamic text, {bool isNewline = true}) {
    if (text == null) {
      log('-----------------------------------------------------------------------------');
      return;
    }
    if (isNewline) {
      log('-----------------------------------------------------------------------------');
    }
    log('=> $text\n');
  }

  static void http(String type, String path, Response response, ResponseModel responseModel) {
    w('✅ $type: $path');
    w('请求头: ${jsonEncode(response.requestOptions.headers)}', isNewline: false);
    w('请求参数: ${jsonEncode(response.requestOptions.data)}', isNewline: false);
    // w('statusCode: ${response.statusCode}', isNewline: false);
    // w('statusMessage: ${response.statusMessage}', isNewline: false);
    w('code: ${responseModel.code}', isNewline: false);
    w('msg: ${responseModel.msg}', isNewline: false);
    w('data: ${jsonEncode(responseModel.data)}', isNewline: false);
  }

  static void dioErr(String type, String path, DioException e) {
    w('❌ $type: $path');
    w('请求头: ${jsonEncode(e.response?.requestOptions.headers)}', isNewline: false);
    w('请求参数: ${jsonEncode(e.response?.extra)}', isNewline: false);
    w('statusCode: ${e.response?.statusCode}', isNewline: false);
    w('statusMessage: ${e.response?.statusMessage}', isNewline: false);
    w('错误信息: ${e.message}', isNewline: false);
    w('错误类型: ${e.type}', isNewline: false);
    w('结果: ${e.response?.data}', isNewline: false);
  }
}
