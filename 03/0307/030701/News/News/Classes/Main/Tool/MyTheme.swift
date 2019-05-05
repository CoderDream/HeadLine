//
//  MyTheme.swift
//  News
//
//  Created by CoderDream on 2019/5/4.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import Foundation
import SwiftTheme

enum MyTheme: Int {
    case day = 0
    case night = 1
    
    static var before = MyTheme.day
    static var current = MyTheme.day
    
    /// 选择主题
    static func switchTo(_ theme: MyTheme) {
        before = current
        current = theme
        
        switch theme {
            case .day: ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
            case .night: ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    /// 选择夜间主题
    static func switchNight(isToNight: Bool) {
        switchTo(isToNight ? .night : .day)
    }
    /// 判断当前是否为夜间主题
    static func isNight() -> Bool {
        return current == .night
    }
}
