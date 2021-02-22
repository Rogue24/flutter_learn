//
//  Flutter.Channel.swift
//  JPFlutterModule
//
//  Created by aa on 2021/2/19.
//

import flutter_boost

/// Flutter 渠道，用于 Flutter 端发起调用原生的方法，可以同步回调参数给回 Flutter 端，属于双向流

extension Flutter {
    static func buildChannel(_ name: String,
                             _ handler: @escaping (_ call: FlutterMethodCall, _ result: @escaping FlutterResult) -> (),
                             _ engine: FlutterEngine) {
        let channelPrefix = Key.channelPrefix
        let messenger = engine.binaryMessenger
        let channel = FlutterMethodChannel(name: channelPrefix + name, binaryMessenger: messenger)
        channel.setMethodCallHandler(handler)
    }
}

/// Flutter 可调用原生的方法：
extension Flutter {
    // MARK:- app_info
    static func appInfoHandler(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        switch call.method {
        case "isDebug":
            result(true)
            
        default:
            // FlutterMethodNotImplemented：目标方法没有实现
            result(FlutterMethodNotImplemented)
        }
    }
    
    // MARK:- device_info
    static func deviceInfoHandler(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result(UIDevice.current.systemVersion)
            
        case "getBatteryInfo":
            let device = UIDevice.current
            // 开启电池探测
            device.isBatteryMonitoringEnabled = true
            // 获取电池信息
            if device.batteryState == .unknown {
                result(FlutterError(code: "拿不到电池信息", message: "拿不到电池信息哦，是不是用了模拟器？", details: nil))
            } else {
                result(Int(device.batteryLevel * 100))
            }
            
        case "getScreenSize":
            result("width: \(UIScreen.main.bounds.width), height: \(UIScreen.main.bounds.height)")
            
        default:
            // FlutterMethodNotImplemented：目标方法没有实现
            result(FlutterMethodNotImplemented)
        }
    }
    
    // MARK:- screen_info
    static func screenInfoHandler(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        switch call.method {
        case "getScreenInfo":
            result(["screen_scale": UIScreen.mainScale,
                    "screen_width": UIScreen.mainWidth,
                    "screen_height": UIScreen.mainHeight])
            
        default:
            // FlutterMethodNotImplemented：目标方法没有实现
            result(FlutterMethodNotImplemented)
        }
    }
    
    // MARK:- image_picker
    static func imagePickerHandler(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        result(FlutterMethodNotImplemented)
    }
    
    // MARK:- test
    static func testHandler(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        switch call.method {
        case "getSomeText":
            result("我来自iOS")
            
        default:
            // FlutterMethodNotImplemented：目标方法没有实现
            result(FlutterMethodNotImplemented)
        }
    }
}
