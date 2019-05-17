//
//  Constant.swift
//  News
//
//  Created by CoderDream on 2019/4/16.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

/// 屏幕的宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width
/// 屏幕的宽度
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let BASE_URL = "https://is.snssdk.com"
let device_id: Int = 6096495334
let iid: Int = 5034850950

let kMyHeaderViewHeight: CGFloat = 280

let isNight = "isNight"

let isIPhoneX: Bool = SCREEN_HEIGHT == 812 ? true : false

/// 关注的用户详情界面 topTab 的按钮的宽度
let topTabButtonWidth: CGFloat = SCREEN_WIDTH * 0.2
/// 关注的用户详情界面 topTab 的指示条的宽度和高度
let topTabIndicatorWidth: CGFloat = 40
let topTabIndicatorHeight: CGFloat = 2
