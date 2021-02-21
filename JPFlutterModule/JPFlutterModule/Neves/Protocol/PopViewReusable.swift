//
//  PopViewReusable.swift
//  Neves_Example
//
//  Created by aa on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

//protocol PopViewReusable: UIView {
//    static func show(onView view: UIView?)
//    func show()
//    func close()
//}
//
//extension PopViewReusable {
//    static func show(onView view: UIView? = nil) {
//        let superview = view ?? UIApplication.shared.keyWindow!
//        let popView = FireworkPopView.loadFromNib()
//        superview.addSubview(popView)
//        
//        popView.snp.makeConstraints { $0.edges.equalToSuperview() }
//        
//        superview.layoutIfNeeded()
//        
//        popView.show()
//
//    }
//    
//    func show() {
//        contentViewBottom.constant = 0
//        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
//            self.layoutIfNeeded()
//            self.layer.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.5).cgColor
//        }, completion: nil)
//    }
//    
//    deinit {
//        JPrint("老子死了吗")
//    }
//    
//    func close() {
//        isUserInteractionEnabled = false
//        contentViewBottom.constant = -(contentViewHeight.constant + 20)
//        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: []) {
//            self.layoutIfNeeded()
//            self.layer.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0).cgColor
//        } completion: { _ in
//            self.removeFromSuperview()
//        }
//    }
//}
