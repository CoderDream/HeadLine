//
//  SettingCell.swift
//  News
//
//  Created by CoderDream on 2019/5/7.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell, RegisterCellOrNib {
    
    var setting: SettingModel? {
        didSet {
            titleLabel.text = setting!.title
            subtitleLabel.text = setting!.subtitle
            rightTitleLabel.text = setting!.rightTitle
            arrowImageView.isHidden = setting!.isHiddenRightArraw
            switchView.isHidden = setting!.isHiddenSwitch
            // 如果有副标题（没有隐藏）
            if !setting!.isHiddenSubtitle {
                subtitleLabelHeight.constant = 20
                // 更新约束
                layoutIfNeeded()
            }
        }
    }
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 副标题
    @IBOutlet weak var subtitleLabel: UILabel!
    /// 右边标题
    @IBOutlet weak var rightTitleLabel: UILabel!
    // 右边箭头
    @IBOutlet weak var arrowImageView: UIImageView!
    /// 开关
    @IBOutlet weak var switchView: UISwitch!
    /// 分割线
    @IBOutlet weak var buttomLine: UIView!
    /// 副标题高度约束
    @IBOutlet weak var subtitleLabelHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 更新主题
        theme_backgroundColor = "colors.cellBackgroundColor"
        buttomLine.theme_backgroundColor = "colors.separatorViewColor"
        titleLabel.theme_textColor = "colors.black"
        rightTitleLabel.theme_textColor = "colors.cellRightTextColor"
        arrowImageView.theme_image = "images.cellRightArrow"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
