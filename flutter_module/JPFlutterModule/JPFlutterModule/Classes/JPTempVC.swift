//
//  JPTempVC.swift
//  JPFlutterModule
//
//  Created by 周健平 on 2021/5/17.
//

import flutter_boost

class JPTempVC: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        view.backgroundColor = .randomColor
        
        let label = UILabel(frame: [50, 200, 250, 100])
        label.text = "我是原生的"
        label.backgroundColor = .randomColor
        label.textColor = .randomColor
        label.textAlignment = .center
        view.addSubview(label)
        
        let btn = UIButton(type: .system)
        btn.setTitle("Push Flutter", for: .normal)
        btn.setTitleColor(.randomColor, for: .normal)
        btn.backgroundColor = .randomColor
        btn.addTarget(self, action: #selector(pushFlutter), for: .touchUpInside)
        btn.sizeToFit()
        btn.origin = [50, 350]
        view.addSubview(btn)
        
        let btn2 = UIButton(type: .system)
        btn2.setTitle("Dismiss", for: .normal)
        btn2.setTitleColor(.randomColor, for: .normal)
        btn2.backgroundColor = .randomColor
        btn2.addTarget(self, action: #selector(close), for: .touchUpInside)
        btn2.sizeToFit()
        btn2.origin = [250, 350]
        view.addSubview(btn2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 恢复导航栏
        navigationController?.setNavigationBarHidden(false, animated: animated)
        // 恢复手势返回
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    deinit {
        JPrint("JPTempVC 死了！")
    }
    
    @objc func pushFlutter() {
        Flutter.Route.jp_test.jump()
    }
    
    @objc func close() {
        dismiss(animated: true, completion: {
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
            guard let navCtr = self.navigationController else { return }
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
    }
    
}

