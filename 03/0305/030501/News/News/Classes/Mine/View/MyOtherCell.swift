//
//  MyOtherCell.swift
//  News
//
//  Created by CoderDream on 2019/4/30.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell, RegisterCellOrNib {
    /// 标题
    @IBOutlet weak var leftLabel: UILabel!
    /// 副标题
    @IBOutlet weak var rightLabel: UILabel!
    /// 右边箭头
    @IBOutlet weak var rightImageView: UIImageView!
    /// 分割线
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightImageView.theme_image = "images.cellRightArrow"
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
