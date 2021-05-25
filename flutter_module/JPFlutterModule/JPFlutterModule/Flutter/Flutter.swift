//
//  Flutter.swift
//  JPFlutterModule
//
//  Created by aa on 2021/2/18.
//

import flutter_boost

struct Flutter {
    static var FBP: FlutterBoostPlugin.Type { FlutterBoostPlugin.self }
    static var fbp: FlutterBoostPlugin { FlutterBoostPlugin.sharedInstance() }
    
    // 常用字段
    enum Key: String {
        case animated
        
        case params
        case present
        
        case native
        case nativePageName
        
        // 用来测试的字段
        case jp_param // 参数
        
        // Channel 前缀域名
        static var channelPrefix: String { "zhoujianping.com/" }
        
        // FlutterBoost 的页面id
        static var pageCallBackId: String { "__callback_id__" }
    }
    
    static func registerFlutter() {
        // 建立路由映射+初始化渠道
        fbp.startFlutter(with: Platform(), onStart: initializeMethodCallHandler)
        // 监听消息
        initializeEventListener()
    }
    
    // Flutter官方提供的Channel：可以 接收消息（setMethodCallHandler）和 发送消息（invokeMethod）
    static var iOSFlutterChannel: FlutterMethodChannel? = nil
}

private extension Flutter {
    //【初始化 Flutter 渠道】
    static func initializeMethodCallHandler(_ engine: FlutterEngine) {
        // Channel初始化的name要跟Flutter端保持一致
        
        // FlutterBoost的Channel配置
        buildChannel("app_info", appInfoHandler, engine)
        buildChannel("device_info", deviceInfoHandler, engine)
        buildChannel("screen_info", screenInfoHandler, engine)
        buildChannel("image_picker", imagePickerHandler, engine)
        buildChannel("test", testHandler, engine)
        
        // Flutter官方提供的Channel
        iOSFlutterChannel = FlutterMethodChannel(name: Key.channelPrefix + "iOSFlutter",
                                                 binaryMessenger: engine.binaryMessenger)
        // 接收消息（消息名要跟Flutter端保持一致）
        iOSFlutterChannel?.setMethodCallHandler(testHandler)
    }
    
    //【监听 Flutter 发出的消息】
    static func initializeEventListener() {
        // 测试一下接收的同时发送
        Event.sendFrom_flutter().addListener { (name, arguments) in
            guard let obName = name, let obArguments = arguments else { return }
            
            JPrint("接收到 Flutter 消息：\(obName) --- \(obArguments)")
            
            guard let viewModel = obArguments["ViewModel"] as? String else { return }
            
            if viewModel == "JPMessageViewModel" {
                Event.sendFrom_native(["message": "来自iOS的消息：通过FlutterBoost发出"]).send()
            }
            
            if viewModel == "JPChannelViewModel" {
                // 发送消息（消息名要跟Flutter端保持一致）
                iOSFlutterChannel?.invokeMethod("event_iOSFlutter",
                                                arguments: ["message": "来自iOS的消息：通过FlutterMethodChannel发出"])
                { result in
                    guard let r = result else { return }
                    JPrint("确定Flutter收到消息了，这是Flutter返回的回调信息 --- \(r)")
                }
            }
        }
    }
}
