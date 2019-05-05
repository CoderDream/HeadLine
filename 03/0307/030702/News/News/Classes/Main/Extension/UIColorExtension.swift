//
//  UIColorExtension.swift
//  News
//
//  Created by CoderDream on 2019/4/16.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        //self.init(red: red, green: green, blue: blue, alpha: alpha)
        self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
}
