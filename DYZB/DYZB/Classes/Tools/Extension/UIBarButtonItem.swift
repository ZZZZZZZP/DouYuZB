//
//  UIBarButtonItem.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/4.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }
        else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        let view = UIView(frame: btn.frame)
        view.addSubview(btn)
        self.init(customView: view)
    }
}



