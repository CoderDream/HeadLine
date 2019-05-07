//
//  SettingModel.swift
//  News
//
//  Created by CoderDream on 2019/5/7.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel: HandyJSON {
    var title: String = ""
    var subtitle: String = ""
    var rightTitle: String = ""
    var isHiddenSubtitle: Bool = false
    var isHiddenRightTitle: Bool = false
    var isHiddenSwitch: Bool = false
    var isHiddenRightArraw: Bool = false
}
