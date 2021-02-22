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
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { routes.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .randomColor(0.7)
        cell.textLabel?.textColor = .randomColor
        
        let route = routes[indexPath.row]
        cell.textLabel?.text = route.name
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        routes[indexPath.row].jump(onPageFinished: { result in
            JPrint("Flutter 返回 iOS --- \(result)")
        })
    }
}
