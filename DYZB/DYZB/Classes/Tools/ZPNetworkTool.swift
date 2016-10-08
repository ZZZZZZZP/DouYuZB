//
//  ZPNetworkTool.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/8.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit
import AFNetworking

class ZPNetworkTool {

    class func getRequestData(URLString: String, params: Any?,  finishedBack: @escaping (_ responseObj: Any?, _ error: Error?)->()) {
        
        let manager = AFHTTPSessionManager()
        
        // 请求数据
        manager.get(URLString, parameters: params, progress: { (progress: Progress) in
            
            }, success: { (_, responseObj: Any?) in
                
                finishedBack(responseObj, nil)
                
        }) { (_, error: Error) in
            
            finishedBack(nil, error)
        }
    }
}

