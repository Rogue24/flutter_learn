import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // ----------------- 实现获取电池信息的功能 -----------------
        // 1.获取 FlutterViewController <==> Flutter 开发的界面在 iOS 里面对应的就是这个 FlutterViewController
        if let ctr: FlutterViewController = window.rootViewController as? FlutterViewController {
            
            // 2.创建对应的 FlutterMethodChannel
            let channel = FlutterMethodChannel(name: "zhoujianping.com/battery", binaryMessenger: ctr.binaryMessenger)
            
            // 3.监听 channel 的方法调用
            channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
                guard let self = self else { return }
                
                switch call.method {
                case "getBatteryInfo":
                    self.getBatteryInfo(result)
                default:
                    // FlutterMethodNotImplemented：目标方法没有实现
                    result(FlutterMethodNotImplemented)
                }
            }
        }
        // ------------------------------------------------------

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func getBatteryInfo(_ result: FlutterResult) {
        let device = UIDevice.current
        // 开启电池探测
        device.isBatteryMonitoringEnabled = true
        // 获取电池信息
        if device.batteryState == .unknown {
            result(FlutterError(code: "拿不到电池信息", message: "拿不到电池信息哦，是不是用了模拟器？", details: nil))
        } else {
            result(Int(device.batteryLevel * 100))
        }
        
//        result(100)
    }

}
