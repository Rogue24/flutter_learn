//
//  Flutter.Channel.swift
//  JPFlutterModule
//
//  Created by aa on 2021/2/19.
//

import flutter_boost

/// Flutter 渠道，用于 Flutter 端发起调用原生的方法，同时可以回调参数给回 Flutter 端，属于双向流
extension Flutter {
    static let channelPrefix = "zhoujianping.com/"
    typealias MethodCallHandler = (_ call: FlutterMethodCall, _ result: @escaping FlutterResult) -> ()
    
    static func initializeMethodCallHandler(_ engine: FlutterEngine) {
        let messenger = engine.binaryMessenger
        buildChannel(for: "app_info", messenger, handler: appInfoHandler)
        buildChannel(for: "device_info", messenger, handler: deviceInfoHandler)
        buildChannel(for: "image_picker", messenger, handler: imagePickerHandler)
        buildChannel(for: "test", messenger, handler: testHandler)
    }
    
    static func buildChannel(for name: String, _ messenger: FlutterBinaryMessenger, handler: @escaping MethodCallHandler) {
        let channel = FlutterMethodChannel(name: channelPrefix + name, binaryMessenger: messenger)
        channel.setMethodCallHandler(handler)
    }
}

// MARK:- app_info
extension Flutter {
    static func appInfoHandler(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        switch call.method {
        case "isDebug":
            result(true)
            
        default:
            // FlutterMethodNotImplemented：目标方法没有实现
            result(FlutterMethodNotImplemented)
        }
    }
}

// MARK:- device_info
extension Flutter {
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
}
 
// MARK:- image_picker
extension Flutter {
    static func imagePickerHandler(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        result(FlutterMethodNotImplemented)
    }
}
    
// MARK:- test
extension Flutter {
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
