//
//  ZPPrettyCell.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/9.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPPrettyCell: ZPAnchorCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor: ZPAnchorModel? {
        didSet{
            // 将属性传给父类
            super.anchor = anchor
            
            // 设置城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
