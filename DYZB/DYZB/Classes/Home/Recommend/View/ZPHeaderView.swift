//
//  ZPHeaderView.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/9.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPHeaderView: UICollectionReusableView {

    // MARK: - 控件属性
    @IBOutlet weak var iconImgV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    // MARK: - 模型属性
    var group: ZPAnchorGroup? {
        
        didSet{
            nameLabel.text = group?.tag_name
            iconImgV.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

// MARK: - 从XIB加载的类方法
extension ZPHeaderView {
    
    class func headerView()->ZPHeaderView {
        
        return Bundle.main.loadNibNamed("ZPHeaderView", owner: nil, options: nil)?.first as! ZPHeaderView
    }
}


