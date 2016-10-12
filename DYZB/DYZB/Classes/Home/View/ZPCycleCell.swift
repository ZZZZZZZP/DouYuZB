//
//  ZPCycleCell.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/11.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit
import Kingfisher

class ZPCycleCell: UICollectionViewCell {
    
    // MARK: - 懒加载属性
    fileprivate lazy var imgView: UIImageView = UIImageView()
    
    // 模型数据
    var cycleModel: ZPCycleModel? {
        didSet{
            let url = URL(string: cycleModel?.pic_url ?? "")
            imgView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"))
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
extension ZPCycleCell {
    
    fileprivate func setupUI() {
        contentView.addSubview(imgView)
    }
    
    // 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.frame = contentView.bounds
    }
}


