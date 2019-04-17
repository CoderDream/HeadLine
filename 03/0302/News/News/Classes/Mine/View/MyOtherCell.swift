//
//  MyOtherCell.swift
//  News
//
//  Created by CoderDream on 2019/4/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
