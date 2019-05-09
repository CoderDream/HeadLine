//
//  HomeNewsTitle.swift
//  News
//
//  Created by CoderDream on 2019/5/8.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import Foundation
import HandyJSON


struct HomeNewsTitle: HandyJSON {
    var category: String = ""
    var tip_new: Int = 0
    var default_add: Int = 0
    var web_url: String = ""
    var concern_id: String = ""
    var icon_url: String = ""
    var flags: Int = 0
    var type: Int = 0
    var name: String = ""
}
