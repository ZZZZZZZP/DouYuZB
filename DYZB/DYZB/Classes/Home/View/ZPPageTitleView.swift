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

// MARK: - 定义常量
private let kScrollLabelH: CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
// MARK: - 分页标题类
class ZPPageTitleView: UIView {

    // MARK: - 定义属性
    fileprivate var titles: [String]
    weak var delegate: PageTitleViewDelegate?
    fileprivate var currentIndex: Int = 0
    
    // MARK: - 懒加载属性
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()
    
    // MARK: - 构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        super.init(frame: frame)

        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI界面
extension ZPPageTitleView {
    
    fileprivate func setupUI(){
        
        // 1.底部线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 1
        bottomLine.frame = CGRect(x: 0, y: height - lineH, width: width, height: lineH)
        addSubview(bottomLine)

        // 2.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 3.添加标题栏label
        setupTitleLabels()
        
        // 4.添加滚动线
        setupScrollLine()
        
    }
    
    // 添加标题栏label
    private func setupTitleLabels(){
        
        let labelW = scrollView.width / CGFloat(titles.count)
        let labelH = scrollView.height - kScrollLabelH
        let labelY: CGFloat = 0
        
        for (i, title) in titles.enumerated(){
            // 1.创建Label设置属性
            let label = UILabel()
            label.tag = i
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            
            // 2.设置Label的Frame
            let labelX = CGFloat(i) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 3.添加到scrollView
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 4.监听Label点击
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tap:))))
        }
    }
    
    private func setupScrollLine(){
        // 1.取出第一个Label
        guard let currentLabel = titleLabels.first else {return}
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 2.设置scrollLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: 0, y: currentLabel.height, width: currentLabel.width, height: kScrollLabelH)
    }
}

// MARK: - 监听Label点击
extension ZPPageTitleView{
    
    @objc fileprivate func titleLabelClick(tap: UITapGestureRecognizer){
        
        let label = titleLabels[currentIndex]
        label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        let currentLabel = tap.view as! UILabel
        currentIndex = currentLabel.tag
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.x = currentLabel.x
        }
    }
}


