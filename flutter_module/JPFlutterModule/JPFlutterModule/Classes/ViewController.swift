//
//  ViewController.swift
//  JPFlutterModule
//
//  Created by 周健平 on 2021/2/17.
//

import UIKit
import Flutter

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let routes: [Flutter.Route] = [.jp_main(), .jp_demo(), .bottom_sheet(), .center_aleat()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .randomColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 瞅瞅安全区域
//        if #available(iOS 11, *),
//           let window = UIApplication.shared.windows.first {
//            JPrint(window.safeAreaInsets)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func sendEventAction(_ sender: UIBarButtonItem) {
        Flutter.Event.sendFrom_native_test(["iOS 发送消息": "美男平"]).send()
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1: return 1
        default: return routes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .randomColor(0.7)
        cell.textLabel?.textColor = .randomColor
        
        switch indexPath.section {
        case 1:
            cell.textLabel?.text = "看看在navCtr中的一个flutter页面里面dismiss后的状况"
            
        default:
            let route = routes[indexPath.row]
            cell.textLabel?.text = route.name
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 1:
            let navCtr = UINavigationController(rootViewController: JPTempVC())
            navCtr.modalPresentationStyle = .fullScreen
            present(navCtr, animated: true, completion: nil)
            
        default:
            routes[indexPath.row].jump(onPageFinished: { result in
                JPrint("Flutter 返回 iOS --- \(result)")
            })
        }
    }
}
