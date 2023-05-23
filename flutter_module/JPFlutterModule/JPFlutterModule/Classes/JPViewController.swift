//
//  JPViewController.swift
//  JPFlutterModule
//
//  Created by aa on 2021/2/20.
//

import UIKit
import flutter_boost

/// 要遵守 FLBFlutterContainer 协议，为了在 close 时能通过 uniqueIDString() 获取对应的控制器进行关闭
@objc class JPViewController: UIViewController, FLBFlutterContainer, UIGestureRecognizerDelegate {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .randomColor
        
        let btn = UIButton(type: .system)
        btn.setTitle("通过 FlutterBoostPlugin 回去", for: .normal)
        btn.setTitleColor(.randomColor, for: .normal)
        btn.frame = [50, 200, 250, 100]
        btn.backgroundColor = .randomColor
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(btn)
        
        let label = UILabel(frame: [0, 350.px, PortraitScreenWidth, 300.px])
        label.numberOfLines = 0
        label.textColor = .randomColor
        label.backgroundColor = .randomColor
        view.addSubview(label)
        
        var str = "参数："
        flb_params.forEach { param in
            str.append("\nket: \(param.key), value: \(param.value)")
        }
        
        label.text = str
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 恢复导航栏
        navigationController?.setNavigationBarHidden(false, animated: animated)
        // 恢复手势返回
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc func goBack() {
        let uid = uniqueIDString()
        guard uid.count > 0 else {
            JPrint("回不去！！！uid 空的！！！")
            return
        }
        Flutter.close(uid, [Flutter.Key.jp_param.rawValue: "从 iOS - JPViewController 回去的"], animated: true) { (finish) in
            JPrint(finish ? "完成" : "失败")
        }
    }
    
    deinit {
        JPrint("JPViewController 卒")
    }
    
//    - (void)willMoveToParentViewController:(UIViewController *)parent {
//        if (parent && _name) {
//            //当VC将要被移动到Parent中的时候，才触发flutter层面的page init
//            [BoostMessageChannel didInitPageContainer:^(NSNumber *r) {}
//                   pageName:_name
//                     params:_params
//                   uniqueId:[self uniqueIDString]];
//        }
//        [super willMoveToParentViewController:parent];
//    }
    
    // MARK:- FLBFlutterContainer
    var flb_name: String = ""
    var flb_params: [AnyHashable: Any] = [:]
    
    func name() -> String { flb_name }
    func params() -> [AnyHashable: Any] { flb_params }
    func uniqueIDString() -> String { flb_params[Flutter.Key.pageCallBackId] as? String ?? "" }
    func setName(_ name: String, params: [AnyHashable: Any]) {
        flb_name = name
        flb_params = params
    }
}
