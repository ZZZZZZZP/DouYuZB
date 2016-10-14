//
//  ZPGameVM.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/13.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPGameVM {

    lazy var gameModels: [ZPGameModel] = [ZPGameModel]()
}

// MARK: - 发送网络请求
extension ZPGameVM {
    
    func requestGameData(finishedBack: @escaping ()->()) {
        
        ZPNetworkTool.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", params: ["shortName": "game"]) { (result) in
            
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArr = resultDict["data"] as? [[String: Any]] else { return }
            
            for dict in dataArr {
                self.gameModels.append(ZPGameModel(dict: dict))
            }
            
            finishedBack()
        }
    }
}


