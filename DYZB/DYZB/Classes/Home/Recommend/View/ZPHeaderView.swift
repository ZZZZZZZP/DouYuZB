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
    
    // MARK: - 模型属性
    var group: ZPAnchorGroup? {
        
        didSet{
            nameLabel.text = group?.tag_name
            iconImgV.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
