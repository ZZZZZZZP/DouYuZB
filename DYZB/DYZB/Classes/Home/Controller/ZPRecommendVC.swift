//
//  ZPRecommendVC.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/8.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

private let kMargin: CGFloat = 10
private let kItemW = (ZPScreenW - 3 * kMargin) / 2
private let kItemH = kItemW * 9 / 16

private let kNormalCellID = "kNormalCellID"

class ZPRecommendVC: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = kMargin
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin)
        
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        //collectionView.delegate = self
        
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

// MARK: - 设置UI界面
extension ZPRecommendVC {
    
    func setupUI() {
        
        view.addSubview(collectionView)
    }
}

// MARK: - 数据源方法
extension ZPRecommendVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.random
        return cell
    }
}

