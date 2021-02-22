//
//  AppDelegate.swift
//  JPFlutterModule
//
//  Created by 周健平 on 2021/2/17.
//

import UIKit
import Flutter
import flutter_boost

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // 1.创建 FlutterEngine
//    static let flutterEngine = FlutterEngine(name: "zhoujianping_flutter_engine")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 2.启动 FlutterEngine
//        Self.flutterEngine.run()
        
        Flutter.registerFlutter()
        
        
        return true
    }
    
    // 3.打开 Flutter 控制器
//    func openFlutterModule() {
//        let flutterVC = FlutterViewController(engine: AppDelegate.flutterEngine, nibName: nil, bundle: nil)
//        flutterVC.view.frame = PortraitScreenBounds
//        flutterVC.view.backgroundColor = .clear
//        flutterVC.modalPresentationStyle = .custom
//
//
////        navigationController?.pushViewController(flutterVC, animated: true)
//         present(flutterVC, animated: true, completion: nil)
//    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

