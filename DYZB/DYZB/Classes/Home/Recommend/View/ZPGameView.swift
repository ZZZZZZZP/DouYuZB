//
//  ZPGameView.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/8.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kItemW: CGFloat = 80

class ZPGameView: UIView {

    // MARK: - 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: self.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let colllectionV = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        colllectionV.backgroundColor = UIColor.white
        colllectionV.showsHorizontalScrollIndicator = false
        colllectionV.dataSource = self
        
        // 注册cell
        colllectionV.register(ZPGameCell.self, forCellWithReuseIdentifier: kGameCellID)
        
        
        return colllectionV
        
    }()
    
    // MARK: - 模型数据
    var groups: [ZPGameModel]? {
        
        didSet{
            // 刷新表格
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI界面
extension ZPGameView {
    
    fileprivate func setupUI() {
     
        addSubview(collectionView)
    }
}

// MARK: - 数据源方法
extension ZPGameView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! ZPGameCell
        
        cell.group = groups![indexPath.item]
        
        return cell
    }
}




