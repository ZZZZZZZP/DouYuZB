//
//  ZPHomeViewCtrl.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/4.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class ZPHomeViewCtrl: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var pageTitleView: ZPPageTitleView = {[weak self] in
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = ZPPageTitleView(frame: CGRect(x: 0, y: kNavBar, width: ZPScreenW, height: kTitleViewH), titles: titles)
        
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    fileprivate lazy var pageView: ZPPageView = {[weak self] in
        // 1.确定frame
        let pageViewH = ZPScreenH - kNavBar - kTitleViewH - ktabBar
        let pageViewFrame = CGRect(x: 0, y: kNavBar + kTitleViewH, width: ZPScreenW, height: pageViewH)
        
        // 2.确定子控制器
        var childVCs = [UIViewController]()
        childVCs.append(ZPRecommendVC())
        
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.random
            childVCs.append(vc)
        }
        let pageV = ZPPageView(frame: pageViewFrame, childVCs: childVCs, parentVC: self)
        pageV.delegate = self
        return pageV
    }()
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        // 设置UI界面
        setupUI()
    }
}

// MARK: - 设置UI界面
extension ZPHomeViewCtrl{
    
    fileprivate func setupUI(){
        
        edgesForExtendedLayout = UIRectEdge.all
        // 设置导航栏
        setupNavBar()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageView)
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

// MARK: - 遵守pageTitleViewDelegate协议
extension ZPHomeViewCtrl: PageTitleViewDelegate {
    
    func pageTitleView(titleView: ZPPageTitleView, selectedIndex index: Int) {
        pageView.setCurrentIndex(index: index)
    }
}

// MARK: - 遵守pageViewDelegate协议
extension ZPHomeViewCtrl: PageViewDelegate {
    
    func pageViewDidScroll(pageView: ZPPageView, progress: CGFloat, leftIndex: Int, rightIndex: Int) {
        
        pageTitleView.setTitleWithProgress(progress: progress, leftIndex: leftIndex, rightIndex: rightIndex)
    }
}

