//
//  ZPRecommendVC.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/8.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit
import AFNetworking

private let kMargin: CGFloat = 10
private let kItemW = (ZPScreenW - 3 * kMargin) / 2
private let kItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 5 / 4
private let kHeaderViewH : CGFloat = 50

private let kCycleViewH = ZPScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class ZPRecommendVC: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var recommendVM: ZPRecommendVM = ZPRecommendVM()
    
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumInteritemSpacing = kMargin
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin)
        
        // 组头部分
        layout.headerReferenceSize = CGSize(width: ZPScreenW, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        // 设置内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
        // 跟随父控件缩放
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 注册cell
        collectionView.register(UINib(nibName: "ZPNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        // 注册颜值cell
        collectionView.register(UINib(nibName: "ZPPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        // 注册头部View
        collectionView.register(UINib(nibName: "ZPHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    // 图片轮播View
    fileprivate lazy var cycleView: ZPCycleView = {
       
        let cycleFrame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: ZPScreenW, height: kCycleViewH)
        
        return ZPCycleView(frame: cycleFrame)
    }()
    
    // 游戏列表View
    fileprivate lazy var gameView: ZPGameView = {
        
        let gameFrame = CGRect(x: 0, y: -kGameViewH, width: ZPScreenW, height: kGameViewH)
        
        return ZPGameView(frame: gameFrame)
    }()
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI界面
        setupUI()
        
        // 请求数据
        loadData()
    }
}

// MARK: - 设置UI界面
extension ZPRecommendVC {
    
    func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
    }
}

// MARK: - 请求数据
extension ZPRecommendVC {
    
    fileprivate func loadData(){
        
        // 轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
        
        // 推荐数据
        recommendVM.requestData {
            
            // 传数据给gameView
            self.gameView.groups = self.recommendVM.anchorGroups
            // 刷新
            self.collectionView.reloadData()
        }
    }
}

// MARK: - 数据源方法
extension ZPRecommendVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recommendVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: ZPAnchorCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! ZPPrettyCell
        }
        else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! ZPNormalCell
        }
        
        cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    // 每一组headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! ZPHeaderView
        
        headView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headView
    }
    
}

// MARK: - 代理方法
extension ZPRecommendVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kItemH)
    }
}

