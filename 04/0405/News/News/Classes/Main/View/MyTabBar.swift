//
//  MyTabBar.swift
//  News
//
//  Created by CoderDream on 2019/4/15.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_tintColor = "colors.tabbarTintColor"
        theme_barTintColor = "colors.cellBackgroundColor"
        addSubview(publishButton)
    }
    
    // private 绝对私有，除了在当前类中房屋，其他类或者该类的扩展都不能访问
    // fileprivate 文件私有，可以在当前类文件中访问
    // open 开放访问
    // internal 默认，也不可以写
    private lazy var publishButton: UIButton = {
        let publishButton = UIButton(type: .custom)
        publishButton.theme_setBackgroundImage("images.publishButtonBackgroundImage", forState: .normal)
        publishButton.theme_setBackgroundImage("images.publishButtonBackgroundSelectedImage", forState: .selected)
        //publishButton.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        //publishButton.setBackgroundImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        publishButton.sizeToFit()
        return publishButton
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 当前 tabBar 的宽度和高度
        let width = frame.width
        let height: CGFloat = 49 // = frame.height
        
        // 8 为图片上移距离
        publishButton.center = CGPoint(x: width * 0.5, y: height * 0.5 - 7)
        
        // 设置其他按钮的 frame
        let buttonWidth: CGFloat = width * 0.2
        let buttonHeight: CGFloat = height
        let buttonY: CGFloat = 0
        
        var index = 0
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) {
                continue
            }
            let buttonX = buttonWidth * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
            index += 1
        }
    }
    
}
