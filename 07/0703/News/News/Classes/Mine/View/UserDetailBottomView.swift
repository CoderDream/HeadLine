//
//  UserDetailBottomView.swift
//  News
//
//  Created by CoderDream on 2019/5/17.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit


protocol UserDetailBottomViewDelegate: class {
    /// bottomView 底部按钮的点击
    func bottomView(clicked button: UIButton, bottomTab: BottomTab)
}

class UserDetailBottomView: UIView {
    
    weak var delegate: UserDetailBottomViewDelegate?
    
    var bottomTabs = [BottomTab]() {
        didSet {
            let buttonWidth = (SCREEN_WIDTH - CGFloat(bottomTabs.count)) / CGFloat(bottomTabs.count)
            // 添加按钮
            for (index, bottomTab) in bottomTabs.enumerated() {
                // 按钮
                let button = UIButton(frame: CGRect(x: CGFloat(index) * (buttonWidth + 1), y: 0, width: buttonWidth, height: height))
                button.setTitle(bottomTab.name, for: .normal)
                button.tag = index
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.theme_setTitleColor("colors.black", forState: .normal)
                button.theme_setImage("images.tabbar-options", forState: .normal)
                button.addTarget(self, action: #selector(bottomTabButtonClicked), for: .touchUpInside)
                addSubview(button)
                // 竖分割线
                if index < bottomTabs.count - 1 {
                    let separatorView = UIView(frame: CGRect(x: button.frame.maxX, y: 6, width: 1, height: 32))
                    separatorView.theme_backgroundColor = "colors.separatorViewColor"
                    addSubview(separatorView)
                }
            }
        }
    }
    
    /// bottomTab 按钮点击事件
    @objc func bottomTabButtonClicked(button: UIButton) {
        delegate?.bottomView(clicked: button, bottomTab: bottomTabs[button.tag])
        let bottomTab = bottomTabs[button.tag]
        if bottomTab.children.count == 0 { // 直接跳转到下一控制器
            
        } else { // 弹出子视图
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
