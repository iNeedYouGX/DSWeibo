//
//  AppDelegate.swift
//  DSWeibo
//
//  Created by JsonBourne on 2020/9/7.
//  Copyright © 2020 JsonBourne. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?;
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 1. 创建window
        window = UIWindow(frame: UIScreen.main.bounds);
        
        // 2. 设置跟控制器
        window?.rootViewController = MainViewController();
        
        // 3. 显示window
        window?.makeKeyAndVisible();
        
        return true
    }

}

