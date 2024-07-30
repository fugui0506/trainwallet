import UIKit
import Flutter
import Photos

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        
        // 创建方法通道，用于与 Flutter 端通信
        let imageChannel = FlutterMethodChannel(name: "com.example.cgwallet/image", binaryMessenger: flutterViewController.binaryMessenger)
        imageChannel.setMethodCallHandler { [weak self] (call, result) in
            self?.handleImageMethodCall(call, result: result)
        }
        
        // 注册其他插件
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // 处理来自 Flutter 端的方法调用
    private func handleImageMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "saveImageToGallery":
                guard let args = call.arguments as? [String: Any],
                      let imagePath = args["path"] as? String else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Image path is required", details: nil))
                    return
                }
                saveImageToGallery(imagePath: imagePath, result: result)
            default:
                result(FlutterMethodNotImplemented)
        }
    }
    
    // 保存图片到相册
    private func saveImageToGallery(imagePath: String, result: @escaping FlutterResult) {
        guard let url = URL(string: imagePath) else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid image path", details: nil))
            return
        }
        
        // 异步保存图片到相册
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
        }) { success, error in
            if success {
                result(true)
            } else {
                let errorMessage = error?.localizedDescription ?? "Unknown error"
                result(FlutterError(code: "SAVE_FAILED", message: "Failed to save image: \(errorMessage)", details: nil))
            }
        }
    }
}
