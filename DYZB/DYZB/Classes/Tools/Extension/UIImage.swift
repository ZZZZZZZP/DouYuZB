//
//  UIImage.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/12.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

extension UIImage {
    
    // 生成圆角图片
    func circleImage(size: CGSize) -> UIImage? {

        // 1.开启位图上下文
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        // 2.设置裁剪区域
        let path = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
        
        // 3.裁剪图片
        path.addClip()
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        // 4.取出图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5.关闭上下文
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


