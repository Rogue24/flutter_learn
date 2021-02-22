//
//  Flutter.Container.swift
//  JPFlutterModule
//
//  Created by aa on 2021/2/19.
//

import flutter_boost

/// Flutter 页面的容器，iOS 使用 UIViewController，一个 VC 对应一个模块内的 Flutter 页面（Flutter之间的跳转都在一个VC内，除非中间跳去原生页面）
extension Flutter {
    class ViewController: FLBFlutterViewContainer, UIGestureRecognizerDelegate {
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // 隐藏导航栏
            navigationController?.setNavigationBarHidden(true, animated: animated)
            // 恢复手势返回
            navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
}
