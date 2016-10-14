//
//  ZPGameVC.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/12.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

private let kMargin: CGFloat = 10
private let kItemW = (ZPScreenW - 2 * kMargin) / 3
private let kItemH = kItemW
private let kHeadViewH: CGFloat = 50
private let kGameViewH: CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class ZPGameVC: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var gameVM: ZPGameVM = ZPGameVM()
    fileprivate lazy var topView: ZPHeaderView = {
        let topView = ZPHeaderView.headerView()
        topView.frame = CGRect(x: 0, y: -(kHeadViewH + kGameViewH), width: ZPScreenW, height: kHeadViewH)
        topView.nameLabel.text = "常用"
        topView.iconImgV.image = UIImage(named: "Img_orange")
        topView.moreBtn.isHidden = true
        
        return topView
    }()
    
    fileprivate lazy var gameView: ZPGameView = {
       
        let frame = CGRect(x: 0, y: -kGameViewH, width: ZPScreenW, height: kGameViewH)
        return ZPGameView(frame: frame)
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin)
        // 组头部分
        layout.headerReferenceSize = CGSize(width: ZPScreenW, height: kHeadViewH)
        
        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionV.backgroundColor = UIColor.white
        // 跟随父控件
        collectionV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // 内边距
        collectionV.contentInset = UIEdgeInsetsMake(kHeadViewH + kGameViewH, 0, 0, 0)
        
        collectionV.dataSource = self
        
        // 注册Cell
        collectionV.register(ZPGameCell.self, forCellWithReuseIdentifier: kGameCellID)
        // 注册头部View
        collectionV.register(UINib(nibName: "ZPHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionV
        
    }()
    
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI()
        // 请求数据
        loadData()
    }
}

// MARK: - 设置UI界面
extension ZPGameVC {
    
    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.addSubview(topView)
        collectionView.addSubview(gameView)
    }
}

// MARK: - 请求数据
extension ZPGameVC {
    
    fileprivate func loadData() {
        
        gameVM.requestGameData { 
            // 刷新表格
            self.collectionView.reloadData()
            
            // 取出10条数据
            let groups = self.gameVM.gameModels[0..<10]
            self.gameView.groups = Array(groups)
        }
    }
}

// MARK: - 数据源方法
extension ZPGameVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gameVM.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! ZPGameCell
        cell.group = gameVM.gameModels[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 取出headView
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! ZPHeaderView

        // 设置属性
        headView.nameLabel.text = "全部"
        headView.iconImgV.image = UIImage(named: "Img_orange")
        headView.moreBtn.isHidden = true
        
        return headView
    }
}




