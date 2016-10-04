//
//  ZPPageTitleView.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/4.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

// MARK: - 定义协议
protocol PageTitleViewDelegate: class {
    
}

class ZPPageTitleView: UIView {

    // MARK: - 定义属性
    fileprivate var titles: [String]?
    weak var delegate: PageTitleViewDelegate?
    
    // MARK: - 懒加载属性
    private lazy var titleLabels: [UILabel] = [UILabel]()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var scrollLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()
    
    // MARK: - 构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI界面
extension ZPPageTitleView {
    
    fileprivate func setupUI(){
        
        let labelW = width / CGFloat(titles!.count)
        let labelH = self.height
        let labelY: CGFloat = 0
        
        for (i, title) in titles!.enumerated(){
            
            let labelX = CGFloat(i) * labelW
            let label = UILabel()
            label.text = title
            label.textAlignment = .center
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            addSubview(label)
        }
    }
}




