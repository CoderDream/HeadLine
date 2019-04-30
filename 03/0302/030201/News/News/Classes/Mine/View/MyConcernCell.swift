//
//  MyConcernCell.swift
//  News
//
//  Created by CoderDream on 2019/4/30.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class MyConcernCell: UITableViewCell, RegisterCellOrNib {
    /// 头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// vip
    @IBOutlet weak var vipImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 新通知
    @IBOutlet weak var tipsButton: UIButton!
    var myConcern: MyConcern? {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: (myConcern?.icon)!))
            nameLabel.text = myConcern?.name
            if let isVerify = myConcern?.is_verify {
                vipImageView.isHidden = !isVerify
            }
            if let tips = myConcern?.tips {
                tipsButton.isHidden = !tips
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tipsButton.layer.borderWidth = 1
        tipsButton.layer.borderColor = UIColor.white.cgColor
    }
    
}
