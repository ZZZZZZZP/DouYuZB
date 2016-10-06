//
//  ZPHomeViewCtrl.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/4.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPHomeViewCtrl: UIViewController {

    // MARK: - 懒加载属性
    private lazy var pageTitleView: UIView = {
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = ZPPageTitleView(frame: CGRect(x: 0, y: 0, width: ZPScreenW, height: 44), titles: titles)
        
        return pageTitleView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupUI()
        
        view.addSubview(pageTitleView)

    }
}

// MARK: - 设置UI界面
extension ZPHomeViewCtrl{
    
    fileprivate func setupUI(){
        
        // 设置导航栏
        setupNavBar()
    }
    
    private func setupNavBar(){
        
        // 设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        navigationItem.rightBarButtonItems = [searchItem, qrcodeItem, historyItem]
    }
}



