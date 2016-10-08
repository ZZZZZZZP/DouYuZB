//
//  ZPPageView.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/6.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

private let cellID = "collectionViewCell"

protocol PageViewDelegate: class {
    
    func pageViewDidScroll(pageView: ZPPageView, progress: CGFloat, leftIndex: Int, rightIndex: Int)
}

class ZPPageView: UIView {

    // MARK: - 定义属性
    fileprivate var childVCs: [UIViewController]
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isTitleClick: Bool = false
    weak var delegate: PageViewDelegate?
    
    // MARK: - 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = self!.bounds.size
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollsToTop = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        return collectionView
    }()
    
    // MARK: - 定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) {
        
        self.childVCs = childVCs
        // 添加到父控制器
        if let parentVC = parentVC {
            for vc in childVCs {
                parentVC.addChildViewController(vc)
            }
        }
        super.init(frame: frame)
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI界面
extension ZPPageView {
    
    fileprivate func setupUI(){
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK: - 数据源方法
extension ZPPageView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        // 给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// MARK: - 代理方法
extension ZPPageView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isTitleClick = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 如果是标题点击,返回
        if isTitleClick {return}
        
        let offsetX = scrollView.contentOffset.x
        if offsetX <= 0||offsetX >= CGFloat(childVCs.count - 1) * scrollView.width {
            return
        }
        
        let leftIndex = Int(offsetX / scrollView.width)
        let rightIndex = leftIndex + 1
        
        let progress = offsetX / scrollView.width - CGFloat(leftIndex)
        
        // 通知代理
        delegate?.pageViewDidScroll(pageView: self, progress: progress, leftIndex: leftIndex, rightIndex: rightIndex)
    }
}

// MARK: - 对外提供的方法
extension ZPPageView {
    
    func setCurrentIndex(index: Int) {
        
        isTitleClick = true
        collectionView.contentOffset.x = CGFloat(index) * collectionView.width
    }
}


