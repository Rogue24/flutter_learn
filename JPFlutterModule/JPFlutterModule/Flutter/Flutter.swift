//
//  Flutter.swift
//  JPFlutterModule
//
//  Created by aa on 2021/2/18.
//

import flutter_boost

struct Flutter {
    enum Key: String {
        case animated
        
        case params
        case present
        
        case native
        case nativePageName
        
        // 用来测试的字段
        case jp_param
        case event_sendFrom_flutter
        case event_sendFrom_native
        case event_sendFrom_native_test
    }
    
    static var pageCallBackId: String { "__callback_id__" }
    static var FBP: FlutterBoostPlugin.Type { FlutterBoostPlugin.self }
    static var fbp: FlutterBoostPlugin { FlutterBoostPlugin.sharedInstance() }
    
    static func registerFlutter() {
        // 建立路由映射+初始化渠道
        fbp.startFlutter(with: Platform(), onStart: initializeMethodCallHandler)
        
        // 监听消息
        initializeEventListener()
    }
}
