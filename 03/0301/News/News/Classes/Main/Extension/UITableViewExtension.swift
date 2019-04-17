//
//  UITableViewExtension.swift
//  News
//
//  Created by CoderDream on 2019/4/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 注册 cell 的方法
    func ymRegisterCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        } else {
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    
    /// 从缓存池出队已经存在的 cell
    func ymDequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
}
