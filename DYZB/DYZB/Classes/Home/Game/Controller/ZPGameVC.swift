//
//  ZPGameVC.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/12.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class ZPGameVC: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        // 跟随父控件
        collectionV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionV.dataSource = self
        
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
        
        return collectionV
        
    }()
    
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI()
    }
}

// MARK: - 设置UI界面
extension ZPGameVC {
    
    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
    }
}

// MARK: - 数据源方法
extension ZPGameVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        
        return cell
    }
}






