//
//  ZPRecommendVM.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/10.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPRecommendVM {

    // MARK: - 懒加载属性
    lazy var anchorGroups: [ZPAnchorGroup] = [ZPAnchorGroup]()
    // 颜值组
    lazy var prettyGroup: ZPAnchorGroup = {
        let group = ZPAnchorGroup()
        group.tag_name = "颜值"
        group.icon_name = "home_header_phone"
        
        return group
    }()
    // 最热组
    lazy var hotGroup: ZPAnchorGroup = {
        let group = ZPAnchorGroup()
        group.tag_name = "热门"
        group.icon_name = "home_header_hot"
        
        return group
    }()
}

// MARK: - 发送网络请求
extension ZPRecommendVM {
    
    // 请求推荐数据
    func requestData(_ finishedBack: @escaping ()->()) {
        
        let params = ["limit": "4", "offset": "0", "time": Date.currentTime()]
        
        // 创建线程组
        let dGroup = DispatchGroup()
        
        // 1.最热
        dGroup.enter()
        ZPNetworkTool.getRequestData("http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: ["time": Date.currentTime()]) { (result, error) in
            
            if error != nil {return}
            guard let resultDict = result as? [String: NSObject] else{return}
            guard let dataArr = resultDict["data"] as? [[String: NSObject]] else {return}
            
            // 字典转模型
            for dict in dataArr {
                self.hotGroup.anchors.append(ZPAnchorModel(dict: dict))
            }
            dGroup.leave()
        }
        
        // 2.颜值
        dGroup.enter()
        ZPNetworkTool.getRequestData("http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: params) { (result, error) in
            
            if error != nil {return}
            guard let resultDict = result as? [String: NSObject] else{return}
            guard let dataArr = resultDict["data"] as? [[String: NSObject]] else {return}
            
            // 字典转模型
            for dict in dataArr {
                self.prettyGroup.anchors.append(ZPAnchorModel(dict: dict))
            }
            dGroup.leave()
        }
        
        // 3.游戏数据
        dGroup.enter()
        ZPNetworkTool.getRequestData("http://capi.douyucdn.cn/api/v1/getHotCate", params: params) { (result, error) in
            
            if error != nil {return}
            guard let resultDict = result as? [String: NSObject] else{return}
            
            guard let dataArr = resultDict["data"] as? [[String: NSObject]] else {return}
            
            // 字典转模型
            for dict in dataArr {
                self.anchorGroups.append(ZPAnchorGroup(dict: dict))
            }
            dGroup.leave()
        }
        
        // 请求数据完成后的回调
        dGroup.notify(queue: DispatchQueue.main) { 
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.hotGroup, at: 0)
            finishedBack()
        }
    }
}






