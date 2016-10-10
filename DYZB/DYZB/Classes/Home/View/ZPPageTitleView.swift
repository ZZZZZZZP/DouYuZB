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
    
    func pageTitleView(_ titleView: ZPPageTitleView, selectedIndex index: Int)
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
    fileprivate func setupTitleLabels(){
        
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
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:))))
        }
    }
    
    fileprivate func setupScrollLine(){
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
    
    @objc fileprivate func titleLabelClick(_ tap: UITapGestureRecognizer){
        
        // 1.取出当前点击的Label
        let currentLabel = tap.view as! UILabel
        
        // 2.如果重复点击,直接返回
        if currentLabel.tag == currentIndex {return}
        
        // 3.获取上一个点击的Label
        let preLabel = titleLabels[currentIndex]
        
        // 4.切换文字颜色
        preLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 5.保存最新的当前下标
        currentIndex = currentLabel.tag
        
        // 6.移动滚动下划线
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.x = currentLabel.x
        }
        
        // 7.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

// MARK: - 对外提供的方法
extension ZPPageTitleView {
    
    func setTitleWithProgress(_ progress: CGFloat, leftIndex: Int, rightIndex: Int) {
        
        let leftLabel = titleLabels[leftIndex]
        let rightLabel = titleLabels[rightIndex]
        
        // 下滑线滚动
        scrollLine.x = leftLabel.x + progress * scrollLine.width
        
        // 颜色渐变
        let colorD = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        leftLabel.textColor = UIColor(r: kSelectColor.0 - colorD.0 * progress, g: kSelectColor.1 - colorD.1 * progress, b: kSelectColor.2 - colorD.2 * progress)
        
        rightLabel.textColor = UIColor(r: kNormalColor.0 + colorD.0 * progress, g: kNormalColor.1 + colorD.1 * progress, b: kNormalColor.2 + colorD.2 * progress)
        
        // 记录最新index
        if progress == 0 {
            currentIndex = Int(scrollLine.x / scrollLine.width)
        }
    }
}



