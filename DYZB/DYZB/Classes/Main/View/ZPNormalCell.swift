//
//  ZPNormalCell.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/9.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPNormalCell: ZPAnchorCell {

    @IBOutlet weak var roomNameL: UILabel!
    
    override var anchor: ZPAnchorModel? {
        didSet{
            // 将属性传给父类
            super.anchor = anchor
            
            // 设置房间名称
            roomNameL.text = anchor?.room_name
        }
    }
    
}
