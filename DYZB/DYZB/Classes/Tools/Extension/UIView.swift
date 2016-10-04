//
//  UIView.swift
//  DYZB
//
//  Created by 张鹏 on 16/10/1.
//  Copyright © 2016年 张鹏. All rights reserved.
//

import UIKit

extension UIView{
    
    var x: CGFloat{
        
        get{
            return frame.origin.x
        }
        set{
            frame.origin.x = newValue
        }
    }
    
    var y: CGFloat{
        
        get{
            return frame.origin.y
        }
        set{
            frame.origin.y = newValue
        }
    }
    
    var width: CGFloat{
        
        get{
            return frame.width
        }
        set{
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat{
        
        get{
            return frame.height
        }
        set{
            frame.size.height = newValue
        }
    }
    
    var centerX: CGFloat{
        
        get{
            return center.x
        }
        set{
            center.x = newValue
        }
    }
    
    var centerY: CGFloat{
        
        get{
            return center.y
        }
        set{
            center.y = newValue
        }
    }

}







