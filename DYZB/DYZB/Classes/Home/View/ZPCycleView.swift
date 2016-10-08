//
//  ZPCycleView.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/8.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

class ZPCycleView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI界面
extension ZPCycleView {
    
    fileprivate func setupUI() {
        
        backgroundColor = UIColor.red
    }
}





