//
//  ZPGameModel.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/14.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPGameModel: NSObject {

    // MARK:- 定义属性
    var tag_name: String = ""
    var icon_url: String = ""
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}






