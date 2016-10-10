//
//  ZPAnchorCell.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/10.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPAnchorCell: UICollectionViewCell {
    
    // MARK: - 控件属性
    @IBOutlet weak var iconImgV: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameL: UILabel!
    
    // MARK: - 模型属性
    var anchor: ZPAnchorModel? {
        
        didSet{
            // 验证是否有值
            guard let anchor = anchor else {return}
            
            
        }
    }
}
