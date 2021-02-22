//
//  Flutter.Event.swift
//  JPFlutterModule
//
//  Created by 周健平 on 2021/2/20.
//

import flutter_boost

/// Flutter 与原生之间的事件发送/接收，属于单向流

protocol FlutterEvent {
    /// 事件名
    var name: String { get }
    /// 参数
    var params: [AnyHashable: Any] { get }
    
    typealias Listener = (_ name: String?, _ arguments: [AnyHashable: Any]?) -> ()
}
extension FlutterEvent {
    /// 发送：给Flutter传递数据
    func send() {
        Flutter.fbp.sendEvent(name, arguments: params)
    }
    
    static func sendEvent(_ event: FlutterEvent) {
        Flutter.fbp.sendEvent(event.name, arguments: event.params)
    }

    /// 接收：监听Flutter传递的数据，返回一个 FLBVoidCallback 闭包，调用这个闭包可以取消接收对应的事件
    @discardableResult
    func addListener(_ listener: @escaping Listener) -> FLBVoidCallback {
        Flutter.fbp.addEventListener(listener, forName: name)
    }
    
    @discardableResult
    static func addEvent(_ event: FlutterEvent, listener: @escaping Listener) -> FLBVoidCallback {
        Flutter.fbp.addEventListener(listener, forName: event.name)
    }
}

extension Flutter {
    enum Event: FlutterEvent {
        case sendFrom_flutter(_ params: [AnyHashable: Any] = [:])
        case sendFrom_native(_ params: [AnyHashable: Any] = [:])
        case sendFrom_flutter_test(_ params: [AnyHashable: Any] = [:])
        case sendFrom_native_test(_ params: [AnyHashable: Any] = [:])
        
        var name: String {
            switch self {
            case .sendFrom_flutter: return "event_sendFrom_flutter"
            case .sendFrom_native: return "event_sendFrom_native"
            case .sendFrom_flutter_test: return "event_sendFrom_flutter_test"
            case .sendFrom_native_test: return "event_sendFrom_native_test"
            }
        }

        var params: [AnyHashable: Any] {
            switch self {
            case let .sendFrom_flutter(params): return params
            case let .sendFrom_native(params): return params
            case let .sendFrom_flutter_test(params): return params
            case let .sendFrom_native_test(params): return params
            }
        }
    }
    
    static func sendEvent(_ name: String, arguments: [AnyHashable: Any] = [:]) {
        Flutter.fbp.sendEvent(name, arguments: arguments)
    }
    
    @discardableResult
    static func addEvent(_ name: String, listener: @escaping FlutterEvent.Listener) -> FLBVoidCallback {
        Flutter.fbp.addEventListener(listener, forName: name)
    }
}
