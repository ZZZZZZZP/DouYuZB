//
//  AppDelegate.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/1.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // 1.创建主窗口
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 2.设置根控制器
        window?.rootViewController = ZPMainTabBarCtrl()
        
        // 3.显示窗口
        window?.makeKeyAndVisible()
        
        return true
    }
}

