//
//  NotificationCenter.Extension.swift
//  Neves_Example
//
//  Created by 周健平 on 2020/10/12.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension NotificationCenter: JPCompatible {}
extension JP where Base: NotificationCenter {
    static func post(name: NSNotification.Name, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        Base.default.post(name: name, object: object, userInfo: userInfo)
    }
    
    static func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        Base.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    
    static func removeObserver(_ observer: Any, name: NSNotification.Name? = nil, object: Any? = nil) {
        if let aName = name {
            Base.default.removeObserver(observer, name: aName, object: object)
        } else {
            Base.default.removeObserver(observer)
        }
    }
}
