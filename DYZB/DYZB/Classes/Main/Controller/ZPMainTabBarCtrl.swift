//
//  ZPMainTabBarCtrl.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/1.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPMainTabBarCtrl: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加子控制器
        addChildVC(ZPHomeViewCtrl.self)
        addChildVC(ZPLiveViewCtrl.self)
        addChildVC(ZPFollowViewCtrl.self)
        addChildVC(ZPProfileViewCtrl.self)
        
        // 设置TabBar
        setupTabBarItem()
    }
    
    fileprivate func addChildVC(_ type: AnyClass){
        
        let vc = type.alloc() as! UIViewController
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
    }
    
    fileprivate func setupTabBarItem(){
        
        let titles = ["首页","直播","关注","我的"]
        let images = ["btn_home_normal",
                      "btn_column_normal",
                      "btn_live_normal",
                      "btn_user_normal"]
        
        let selectedImages = ["btn_home_selected",
                              "btn_column_selected",
                              "btn_live_selected",
                              "btn_user_selected"]
        
        for (i, vc) in childViewControllers.enumerated(){
            
            vc.tabBarItem.title = titles[i]
            vc.tabBarItem.image = UIImage(named: images[i])
            vc.tabBarItem.selectedImage = UIImage(named: selectedImages[i])
        }
    }
}



