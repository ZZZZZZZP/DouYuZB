//
//  NSDate.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/10.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import Foundation

extension Date {
    
    static func currentTime() -> String {
        
        let interval = Date().timeIntervalSince1970
        
        return "\(interval)"
    }
}
