//
//  ZPAnchorGroup.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/10.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPAnchorGroup: NSObject {

    var room_list: [[String: NSObject]]? {
        
        didSet{
            guard let room_list = room_list else {return}
            
            for dict in room_list {
                anchors.append(ZPAnchorModel(dict: dict))
            }
        }
    }
    var tag_name: String = ""
    var icon_name: String = "home_header_normal"
    var icon_url: String = ""
    
    // 主播模型数组
    lazy var anchors: [ZPAnchorModel] = [ZPAnchorModel]()
    
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
