//
//  UICollectionViewExtension.swift
//  News
//
//  Created by CoderDream on 2019/4/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// 注册 cell 的方法
    func ymRegisterCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        } else {
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    /// 从缓存池出队已经存在的 cell
    func ymDequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
}
