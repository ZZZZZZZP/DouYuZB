//
//  ZPNetworkTool.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/8.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire

enum MethodType {
    case get
    case post
}

class ZPNetworkTool {

    // Alamofire
    class func requestData(type: MethodType, URLString: String, params: [String: Any]? = nil, finishedBack: @escaping (_ result: Any)->()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method , parameters: params).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            finishedBack(result)
        }
    }
    
    // AFNetworking
    class func getRequestData(_ URLString: String, params: Any?,  finishedBack: @escaping (_ responseObj: Any?, _ error: Error?)->()) {
        
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


