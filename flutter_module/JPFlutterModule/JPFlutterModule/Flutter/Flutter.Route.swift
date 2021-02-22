//
//  Flutter.Route.swift
//  JPFlutterModule
//
//  Created by aa on 2021/2/19.
//

import flutter_boost

/// 原生 <-> Flutter 路由的封装

protocol FlutterRoute {
    /// 路由名
    var name: String { get }
    /// 路由参数
    var params: [String: Any] { get }
    
    /// 跳转前的参数修改
    typealias ParamMap = (_ oldParam: [String: Any]) -> [String: Any]

    /// 关闭（Flutter --> iOS）回传的参数
    typealias OnPageFinished = (_ result: [AnyHashable : Any]) -> ()

    /// 跳转/关闭完成的回调
    typealias Completion = (_ isFinished: Bool) -> ()
}
extension FlutterRoute {
    func jump(animated: Bool = true,
              isModal: Bool = false,
              paramMap: FlutterRoute.ParamMap? = nil,
              onPageFinished: @escaping OnPageFinished = { _ in },
              completion: @escaping Completion = { _ in }) {

        let urlParams = paramMap.map { $0(params) } ?? params

        if isModal {
            Flutter.FBP.present(name, urlParams: urlParams, exts: [Flutter.Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
        } else {
            Flutter.FBP.open(name, urlParams: urlParams, exts: [Flutter.Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
        }
    }
    
    static func jump(_ route: FlutterRoute,
                     animated: Bool = true,
                     isModal: Bool = false,
                     paramMap: FlutterRoute.ParamMap? = nil,
                     onPageFinished: @escaping FlutterRoute.OnPageFinished = { _ in },
                     completion: @escaping FlutterRoute.Completion = { _ in }) {
        
        let urlParams = paramMap.map { $0(route.params) } ?? route.params
        
        if isModal {
            Flutter.FBP.present(route.name, urlParams: urlParams, exts: [Flutter.Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
        } else {
            Flutter.FBP.open(route.name, urlParams: urlParams, exts: [Flutter.Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
        }
    }
}

extension Flutter {
    enum Route: FlutterRoute {
        case jp_main(_ params: [String: Any] = [Key.jp_param.rawValue: "你好帅哦"])
        case jp_demo(_ params: [String: Any] = [Key.jp_param.rawValue: "从iOS push过来的"])
        case bottom_sheet(_ params: [String: Any] = [:])
        case center_aleat(_ params: [String: Any] = [:])

        var name: String {
            switch self {
            case .jp_main: return "/jp_main"
            case .jp_demo: return "/jp_demo"
            case .bottom_sheet: return "/bottom_sheet"
            case .center_aleat: return "/center_aleat"
            }
        }

        var params: [String: Any] {
            switch self {
            case let .jp_main(params): return params
            case let .jp_demo(params): return params
            case let .bottom_sheet(params): return params
            case let .center_aleat(params): return params
            }
        }
    }
    
    static func push(_ url: String,
                     _ params: [String: Any],
                     animated: Bool = true,
                     onPageFinished: @escaping FlutterRoute.OnPageFinished = { _ in },
                     completion: @escaping FlutterRoute.Completion = { _ in }) {
        FBP.open(url, urlParams: params, exts: [Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
    }
    
    static func present(_ url: String,
                        _ params: [AnyHashable : Any],
                        animated: Bool = true,
                        onPageFinished: @escaping FlutterRoute.OnPageFinished = { _ in },
                        completion: @escaping FlutterRoute.Completion = { _ in }) {
        FBP.present(url, urlParams: params, exts: [Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
    }
    
    static func close(_ uid: String,
                      _ result: [String: Any] = [:],
                      animated: Bool = true,
                      completion: @escaping FlutterRoute.Completion = { _ in }) {
        FBP.close(uid, result: result, exts: [Key.animated.rawValue: animated], completion: completion)
    }
    
    /// 显示一个底部弹出来的半透明flutter page
    /// - Parameters:
    ///   - url: route name
    ///   - urlParams: parms
//    @objc dynamic func openBottomSheet(_ url: String, urlParams: [AnyHashable : Any], completion: ((Bool) -> Void)? = nil) {
//        self.router.present(url, urlParams: urlParams, exts: ["bgColor":UIColor.clear,"animated":false]) { (finished) in
//            completion?(finished)
//        }
//    }
}
