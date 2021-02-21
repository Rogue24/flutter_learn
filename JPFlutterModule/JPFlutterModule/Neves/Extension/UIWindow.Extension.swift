//
//  UIWindow.Extension.swift
//  Neves_Example
//
//  Created by 周健平 on 2020/10/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension JP where Base: UIWindow {
    
    static var keyWindowTopVC: UIViewController? {
        guard let window = UIApplication.shared.windows.first else { return nil }
        return window.jp.topVC
    }
    
    static var delegateWindowTopVC: UIViewController? {
        guard let window = UIApplication.shared.delegate?.window ?? nil else { return nil }
        return window.jp.topVC
    }
    
    /**
     * 获取顶层控制器
     */
    var topVC: UIViewController? {
        guard let rootVC = base.rootViewController,
              let topVC = getTopViewController(rootVC) else { return nil }
        
        var resultVC: UIViewController? = topVC
        
        while let obResultVC = resultVC,
              let presentedVC = obResultVC.presentedViewController {
            resultVC = getTopViewController(presentedVC)
        }
        
        guard let obResultVC = resultVC else { return nil }
        
        if let alertCtr = obResultVC as? UIAlertController {
            if let presentedVC = alertCtr.presentedViewController  {
                return getTopViewController(presentedVC)
            }
            return nil
        }
        
        return obResultVC
    }
    
    private func getTopViewController(_ fromVC: UIViewController) -> UIViewController? {
        if let navCtr = fromVC as? UINavigationController, let topVC = navCtr.topViewController {
            return getTopViewController(topVC)
        }
        
        if let tabBarCtr = fromVC as? UITabBarController, let selVC = tabBarCtr.selectedViewController {
            return getTopViewController(selVC)
        }
        
        return fromVC
    }
    
}
