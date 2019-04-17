//
//  UIViewExtension.swift
//  News
//
//  Created by CoderDream on 2019/4/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

protocol RigisterCellOrNib {
    
}

extension RigisterCellOrNib {
    static var identifier: String {
        return "\(self)"
    }
    
    static var nib: UINib? {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
