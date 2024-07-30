package com.example.cgwallet

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    companion object {
        const val DEVICE_CHANNEL = "com.example.cgwallet/device_info"
        const val IMAGE_CHANNEL = "com.example.cgwallet/image"
    }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // 注册 DeviceHandler
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DEVICE_CHANNEL).setMethodCallHandler(DeviceHandler(this))

        // 注册 ImageHandler
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, IMAGE_CHANNEL).setMethodCallHandler(ImageHandler(this))
    }
}