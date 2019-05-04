//
//  NoLoginHeaderView.swift
//  News
//
//  Created by CoderDream on 2019/5/3.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import IBAnimatable

class NoLoginHeaderView: UIView {

    class func headerView() -> NoLoginHeaderView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! NoLoginHeaderView
    }

}
