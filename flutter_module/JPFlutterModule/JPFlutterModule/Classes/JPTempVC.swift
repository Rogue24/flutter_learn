//
//  JPTempVC.swift
//  JPFlutterModule
//
//  Created by 周健平 on 2021/5/17.
//

class JPTempVC: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .randomColor
        
        let btn = UIButton(type: .system)
        btn.setTitle("我是原生的", for: .normal)
        btn.setTitleColor(.randomColor, for: .normal)
        btn.frame = [50, 200, 250, 100]
        btn.backgroundColor = .randomColor
        btn.addTarget(self, action: #selector(go), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func go() {
        Flutter.Route.jp_test.jump()
    }
}

