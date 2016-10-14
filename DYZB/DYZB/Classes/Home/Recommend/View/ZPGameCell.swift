//
//  ZPGameCell.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/11.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPGameCell: UICollectionViewCell {
    
    // MARK: - 懒加载属性
    fileprivate var imgView: UIImageView = UIImageView()
    fileprivate var nameLabel: UILabel = UILabel()
    fileprivate var bottomLine: UIView = UIView()
    
    // MARK: - 模型属性
    var group: ZPGameModel? {
        didSet{
            
            nameLabel.text = group?.tag_name
            
            if let url = URL(string: group?.icon_url ?? "") {
                imgView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, _, _, _) in
                    
                    self.imgView.image = image?.circleImage(size: self.imgView.bounds.size)
                }
            }else {
                let image = UIImage(named: "home_more_btn")
                imgView.image = image?.circleImage(size: imgView.bounds.size)
            }
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
extension ZPGameCell {
    
    fileprivate func setupUI() {
        
        contentView.addSubview(imgView)
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textAlignment = .center
        
        contentView.addSubview(bottomLine)
        bottomLine.backgroundColor = UIColor.darkGray
        bottomLine.alpha = 0.5
    }
    
    // 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        // 图片
        let imgWH: CGFloat = 45
        imgView.bounds.size = CGSize(width: imgWH, height: imgWH)
        imgView.centerX = contentView.width * 0.5
        imgView.centerY = contentView.height * 0.5 - 10
        
        // 文字
        nameLabel.frame = CGRect(x: 0, y: imgView.frame.maxY + 5, width: contentView.width, height: 15)
        
        // 下面线
        bottomLine.frame = CGRect(x: 0, y: contentView.height, width: contentView.width, height: 1)
    }
}


