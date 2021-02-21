//
//  Flutter.Event.swift
//  JPFlutterModule
//
//  Created by 周健平 on 2021/2/20.
//

import flutter_boost

/// Flutter 事件发送/接收，属于单向流
extension Flutter {
    static func initializeEventListener() {
        // 测试一下接收的同时发送
        addEventListener(Key.event_sendFrom_flutter.rawValue) { (name, arguments) in
            guard let obName = name, let obArguments = arguments else { return }
            
            JPrint("接收到 Flutter 消息：\(obName) --- \(obArguments)")
            sendEvent(Key.event_sendFrom_native.rawValue, arguments: obArguments)
        }
    }
}

extension Flutter {
    typealias EventListener = (_ name: String?, _ arguments: [AnyHashable: Any]?) -> ()
    
    /// 发送：给Flutter传递数据
    static func sendEvent(_ name: String, arguments: [AnyHashable: Any]) {
        fbp.sendEvent(name, arguments: arguments)
    }

    /// 接收：监听Flutter传递的数据
    static func addEventListener(_ name: String, listener: @escaping EventListener) {
        fbp.addEventListener(listener, forName: name)
    }
}
