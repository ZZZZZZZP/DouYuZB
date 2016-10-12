//
//  ZPCycleModel.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/11.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPCycleModel: NSObject {

    // 标题
    var title: String = ""
    // 展示的图片地址
    var pic_url: String = ""
    // 主播信息对应的字典
    var room: [String : NSObject]? {
        didSet {
            guard let room = room else  { return }
            anchor = ZPAnchorModel(dict: room)
        }
    }
    // 主播模型对象
    var anchor: ZPAnchorModel?
    
    // MARK:- 自定义构造函数
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}




