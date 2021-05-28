//
//  Flutter.Platform.swift
//  JPFlutterModule
//
//  Created by aa on 2021/2/19.
//

import flutter_boost

/// FLBPlatform：实现 Flutter 在原生的跳转/关闭的驱动（FlutterBoostPlugin 会调用这些方法，类似协议）
/// 跳转/关闭【不要直接使用这里的方法】，而是使用 FlutterBoostPlugin 的类方法去执行
extension Flutter {
    class Platform: NSObject, FLBPlatform {
        /**
         * 基于Native平台实现页面打开，Dart层的页面打开能力依赖于这个函数实现；Native或者Dart侧不建议直接使用这个函数。应直接使用FlutterBoost封装的函数
         *
         * @param url 打开的页面资源定位符
         * @param urlParams 传人页面的参数; 若有特殊逻辑，可以通过这个参数设置回调的id
         * @param exts 额外参数
         * @param completion 打开页面的即时回调，页面一旦打开即回调
         */
        func open(_ url: String,
                  urlParams: [AnyHashable: Any],
                  exts: [AnyHashable: Any],
                  completion: @escaping (Bool) -> Void) {
            
            guard let topVC = UIWindow.jp.keyWindowTopVC else {
                completion(false)
                return
            }
            
            let animated = (exts[Key.animated.rawValue].map { $0 } as? Bool) ?? true
            
            if url == Key.native.rawValue {
                jumpNative(with: topVC, isModal: false, urlParams, animated, completion)
                return
            }
            
            let flbVC = Flutter.ViewController()
            flbVC.setName(url, params: urlParams)
            
            if let navCtr = topVC.navigationController {
                navCtr.pushViewController(flbVC, animated: animated)
                completion(true)
            } else {
                topVC.present(flbVC, animated: animated) { completion(true) }
            }
        }
        
        /**
         * 基于Native平台实现present页面打开，Dart层的页面打开能力依赖于这个函数实现；Native或者Dart侧不建议直接使用这个函数。应直接使用FlutterBoost封装的函数
         *
         * @param url 打开的页面资源定位符
         * @param urlParams 传人页面的参数; 若有特殊逻辑，可以通过这个参数设置回调的id
         * @param exts 额外参数
         * @param completion 打开页面的即时回调，页面一旦打开即回调
         */
        func present(_ url: String,
                     urlParams: [AnyHashable: Any],
                     exts: [AnyHashable: Any],
                     completion: @escaping (Bool) -> Void) {
            
            guard let topVC = UIWindow.jp.keyWindowTopVC else {
                completion(false)
                return
            }
            
            let animated = (exts[Key.animated.rawValue].map { $0 } as? Bool) ?? true
            
            if url == Key.native.rawValue {
                jumpNative(with: topVC, isModal: true, urlParams, animated, completion)
                return
            }
            
            let flbVC = Flutter.ViewController()
            flbVC.setName(url, params: urlParams)
            
            /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
             * FLBFlutterViewContainer 是在 willMoveToParentViewController 把close的回调闭包放到一个静态字典里面缓存（key为vcID），然后 close 时从静态字典里面拿到回调闭包进行回传：
             
                 - (void)willMoveToParentViewController:(UIViewController *)parent {
                     if (parent && _name) {
                         //当VC将要被移动到Parent中的时候，才出发flutter层面的page init
                         [BoostMessageChannel didInitPageContainer:^(NSNumber *r) {}
                                pageName:_name
                                  params:_params
                                uniqueId:[self uniqueIDString]];
                     }
                     [super willMoveToParentViewController:parent];
                 }
             
             * 由于 present 方式并没有触发 willMoveToParentViewController，所以在这里自己调用一下触发吧。
             * PS：目前在外部拿不到 BoostMessageChannel 来调用
             */
            flbVC.willMove(toParent: flbVC)
            
            topVC.present(flbVC, animated: animated) { completion(true) }
        }

        /**
         * 基于Native平台实现页面关闭，Dart层的页面关闭能力依赖于这个函数实现；Native或者Dart侧不建议直接使用这个函数。应直接使用FlutterBoost封装的函数
         *
         * @param uid 关闭的页面唯一ID符
         * @param result 页面要返回的结果（给上一个页面），会作为页面返回函数的回调参数
         * @param exts 额外参数
         * @param completion 关闭页面的即时回调，页面一旦关闭即回调
         */
        func close(_ uid: String,
                   result: [AnyHashable: Any],
                   exts: [AnyHashable: Any],
                   completion: @escaping (Bool) -> Void) {
            
            guard let topVC = UIWindow.jp.keyWindowTopVC,
                  let flbVC = topVC as? (UIViewController & FLBFlutterContainer),
                  flbVC.uniqueIDString() == uid else {
                completion(false)
                return
            }
            
            //【result 会在 onPageFinished 回调里面给到】
            JPrint("iOS 接收 Flutter close result --- \(result)")
            JPrint("iOS 接收 Flutter close exts --- \(exts)")
            JPrint("-----------------")
            
            let animated = (exts[Key.animated.rawValue].map { $0 } as? Bool) ?? true
            
//            // present = exts["params"]["present"]
//            if let params = exts[Key.params.rawValue] as? [AnyHashable: Any],
//               let present = params[Key.present.rawValue] as? Bool, present == true {
//                flbVC.dismiss(animated: animated, completion: { completion(true) })
//                return
//            }
            /* ↓↓↓↓↓↓↓↓↓↓↓
             * 官方文档的 present 是放在 exts["params"]["present"] 里面
             * 但是当调用 FlutterBoost.singleton.closeCurrent(exts: {"params": {"present": true}}) 时，
             * 内部有这样一句代码：exts["params"] = settings.params
             * 日尼玛这不就把 "params" 覆盖了嘛！！！难怪一直拿不到！！！
             * 所以直接放 exts["present"] 这里好了！！！
             */
            
            // present = exts["present"]
            if let present = exts[Key.present.rawValue] as? Bool, present == true {
                flbVC.dismiss(animated: animated, completion: {
                    defer { completion(true) }
                    /*
                     *【导航控制器dismiss方法会内存泄漏！！！！！！】
                     *【Flutter页面控制器】都是 FLBFlutterViewContainer 这个类
                     * FLBFlutterViewContainer 内部要调用 notifyWillDealloc 才能触发dart端去销毁页面，才会真正的死去
                     *【不执行 notifyWillDealloc 就死不了，flutter_boost只是把它隐藏了】
                     * 但是 notifyWillDealloc 是内部方法（只在.m文件），只在 dismiss 和 didMove(toParent: nil) 方法里面调用
                     * 可是这里只有这个【close方法的调用者】才会调用 dismiss，并且如果是【Flutter页面控制器】才会从而触发 notifyWillDealloc 去销毁！
                     * 然而导航控制器里面其他的【Flutter页面控制器】并不会自动执行 didMove(toParent: nil)，因此其他的vc根本没死去！
                     
                     * 解决方法：dismiss后【手动】调用其他的 Flutter页面控制器 的 didMove(toParent: nil) 或 perform(Selector(("notifyWillDealloc"))) 方法！
                     * 注意：在 notifyWillDealloc 之前要先调用 viewDidDisappear，否则【Flutter页面控制器】不会立马去死，可能会慢个几秒吧（垃圾）
                     
                     * viewDidDisappear的内部实现：
                         - (void)viewDidDisappear:(BOOL)animated
                         {
                             [BoostMessageChannel didDisappearPageContainer:^(NSNumber *result) {}
                                                                         pageName:_name
                                                                           params:_params
                                                                         uniqueId:self.uniqueIDString];
                             [super bridge_viewDidDisappear:animated];
                         }
                     
                     * notifyWillDealloc的内部实现：
                         - (void)notifyWillDealloc
                         {
                             [BoostMessageChannel willDeallocPageContainer:^(NSNumber *r) {}
                                                                        pageName:_name params:_params
                                                                        uniqueId:[self uniqueIDString]];

                             [FLUTTER_APP removeViewController:self];
                             
                             [self.class instanceCounterDecrease];
                         }
                     */
                    guard let navCtr = flbVC.navigationController else { return }
                    for vc in navCtr.viewControllers where vc is FLBFlutterViewContainer {
                        // performSelector不太安全
                        // vc.perform(Selector(("notifyWillDealloc")))
                        
                        // ↓↓↓↓↓最保险死法↓↓↓↓↓
                        vc.viewDidDisappear(false)
                        vc.view.removeFromSuperview()
                        vc.didMove(toParent: nil)
                        vc.removeFromParent()
                    }
                })
                return
            }
            
            if let navCtr = flbVC.navigationController, navCtr.viewControllers.count > 1 {
                navCtr.popViewController(animated: animated)
                completion(true)
            } else {
                flbVC.dismiss(animated: animated, completion: { completion(true) })
            }
        }
        
        // MARK:- 打开原生界面
        #warning("现在只能单向传数据【Flutter -> 原生】，迟些自己写一个 Event 来实现【Flutter <-> 原生】之间的回传机制吧")
        // iOS -> sendEvent
        // Flutter -> provider -> 创建ViewModel -> addEventListener
        private func jumpNative(with topVC: UIViewController,
                                isModal: Bool,
                                _ params: [AnyHashable: Any],
                                _ animated: Bool,
                                _ completion: @escaping (Bool) -> Void) {
            guard let nativePageName = params[Key.nativePageName.rawValue] as? String else {
                return
            }
            
            let className = Bundle.jp.executable() + "." + nativePageName
            guard let vcType = NSClassFromString(className) as? UIViewController.Type else {
                return
            }
            
            let vc = vcType.init()
            
            typealias FlbVc = UIViewController & FLBFlutterContainer
            if let flbVC = vc as? FlbVc {
                flbVC.setName(Key.native.rawValue, params: params)
                if isModal, flbVC is FLBFlutterViewContainer {
                    // 垃圾FLBFlutterViewContainer：由于 present 方式并没有触发 willMoveToParentViewController，所以在这里自己调用一下触发吧。
                    flbVC.willMove(toParent: flbVC)
                }
            }
            
            if !isModal, let navCtr = topVC.navigationController {
                navCtr.pushViewController(vc, animated: animated)
                completion(true)
            } else {
                topVC.present(vc, animated: animated) { completion(true) }
            }
        }
        
    }
}
