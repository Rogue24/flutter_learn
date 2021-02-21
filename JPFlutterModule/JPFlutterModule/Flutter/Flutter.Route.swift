//
//  Flutter.Route.swift
//  JPFlutterModule
//
//  Created by aa on 2021/2/19.
//

import flutter_boost

/// 原生 <-> Flutter 路由的封装
extension Flutter {
    enum Route {
        case jp_main(_ params: [String: Any] = ["jp_param": "你好帅哦"])
        case jp_demo(_ params: [String: Any] = ["jp_param": "从iOS push过来的"])
        case bottom_sheet(_ params: [String: Any] = [:])
        case center_aleat(_ params: [String: Any] = [:])
        
        var routeName: String {
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
        
        /// 跳转前的参数修改
        typealias ParamMap = (_ oldParam: [String: Any]) -> [String: Any]
        
        /// 关闭（Flutter --> iOS）回传的参数
        typealias OnPageFinished = (_ result: [AnyHashable : Any]) -> ()
        
        /// 跳转/关闭完成的回调
        typealias Completion = (_ isFinished: Bool) -> ()
        
        func jump(animated: Bool = true,
                  isModal: Bool = false,
                  paramMap: ParamMap? = nil,
                  onPageFinished: @escaping OnPageFinished = { _ in },
                  completion: @escaping Completion = { _ in }) {
            
            let urlParams = paramMap.map { $0(params) } ?? params
            
            if isModal {
                FBP.present(routeName, urlParams: urlParams, exts: [Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
            } else {
                FBP.open(routeName, urlParams: urlParams, exts: [Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
            }
        }
    }
}

extension Flutter {
    static func jump(_ route: Route,
                     animated: Bool = true,
                     isModal: Bool = false,
                     paramMap: Route.ParamMap? = nil,
                     onPageFinished: @escaping Route.OnPageFinished = { _ in },
                     completion: @escaping Route.Completion = { _ in }) {
        
        let urlParams = paramMap.map { $0(route.params) } ?? route.params
        
        if isModal {
            FBP.present(route.routeName, urlParams: urlParams, exts: [Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
        } else {
            FBP.open(route.routeName, urlParams: urlParams, exts: [Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
        }
    }
    
    static func push(_ url: String,
                     _ params: [String: Any],
                     animated: Bool = true,
                     onPageFinished: @escaping Route.OnPageFinished = { _ in },
                     completion: @escaping Route.Completion = { _ in }) {
        FBP.open(url, urlParams: params, exts: [Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
    }
    
    static func present(_ url: String,
                        _ params: [AnyHashable : Any],
                        animated: Bool = true,
                        onPageFinished: @escaping Route.OnPageFinished = { _ in },
                        completion: @escaping Route.Completion = { _ in }) {
        FBP.present(url, urlParams: params, exts: [Key.animated.rawValue: animated], onPageFinished: onPageFinished, completion: completion)
    }
    
    static func close(_ uid: String,
                      _ result: [String: Any] = [:],
                      animated: Bool = true,
                      completion: @escaping Route.Completion = { _ in }) {
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
