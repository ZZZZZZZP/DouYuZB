//
//  ZPCycleView.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/8.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class ZPCycleView: UIView {
    
    // MARK: - 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let colllectionV = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        colllectionV.showsHorizontalScrollIndicator = false
        colllectionV.isPagingEnabled = true
        colllectionV.dataSource = self
        colllectionV.delegate = self
        
        // 注册cell
        colllectionV.register(ZPCycleCell.self, forCellWithReuseIdentifier: kCycleCellID)
        
        return colllectionV
        
        }()
    
    fileprivate lazy var pageCtrl: UIPageControl = {[unowned self] in
        
        let pageCtrl = UIPageControl()
        pageCtrl.pageIndicatorTintColor = UIColor(white: 1, alpha: 0.5)
        pageCtrl.currentPageIndicatorTintColor = UIColor.green
        
        let pageW: CGFloat = 100
        let pageH: CGFloat = 30
        let pageX = self.width - pageW - 10
        let pageY = self.height - pageH
        pageCtrl.frame = CGRect(x: pageX, y: pageY, width: pageW, height: pageH)
        
        return pageCtrl
        }()
    
    // 定时器
    fileprivate var cycleTimer: Timer?
    
    // 模型数据
    var cycleModels: [ZPCycleModel]? {
        didSet{
            // 1.刷新数据
            collectionView.reloadData()
            // 2.设置分页个数
            pageCtrl.numberOfPages = cycleModels?.count ?? 0
            // 3.滚动到某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 2, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
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
extension ZPCycleView {
    
    fileprivate func setupUI() {
        
        addSubview(collectionView)
        addSubview(pageCtrl)
    }
}

// MARK: - 数据源方法
extension ZPCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (cycleModels?.count ?? 0) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! ZPCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
}

// MARK: - 代理方法
extension ZPCycleView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageCtrl.currentPage = Int(scrollView.contentOffset.x / scrollView.width + 0.5) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        addCycleTimer()
    }
}

// MARK: - 操作定时器
extension ZPCycleView {
    
    // 添加定时器
    fileprivate func addCycleTimer() {
        
        cycleTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    // 移除定时器
    fileprivate func removeCycleTimer() {
        
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    // 滚到下一张
    @objc private func scrollToNext() {
        
        let offsetX = collectionView.contentOffset.x + ZPScreenW
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}




