//
//  MyTabBarController.swift
//  News
//
//  Created by CoderDream on 2019/4/15.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //print(tabBar.subviews)
        // [<UITabBarButton: 0x10162ae10; frame = (0 0; 32 49); opaque = NO; layer = <CALayer: 0x281afc860>>,
        //  <UITabBarButton: 0x101605660; frame = (0 0; 32 49); opaque = NO; layer = <CALayer: 0x281af0a60>>,
        //  <UITabBarButton: 0x1016310a0; frame = (0 0; 32.6667 49); opaque = NO; layer = <CALayer: 0x281af19a0>>,
        //  <UITabBarButton: 0x101631b30; frame = (0 0; 32 49); opaque = NO; layer = <CALayer: 0x281af1520>>]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 TabBar 字体颜色
        let myTabBar = UITabBar.appearance()
        myTabBar.tintColor = UIColor(displayP3Red: 245 / 255.0, green: 90 / 255.0, blue: 93 / 255.0, alpha: 1.0)
        // 添加子控制器
        addChildViewControllers()
        // tabBar 是 readonly 属性，不能直接修改，利用 KVC 把 readonly 属性的权限改过来
        setValue(MyTabBar(), forKey: "tabBar")
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    /// 接收到了按钮点击的通知
    @objc func receiveDayOrNightButtonClicked(notification: Notification) {
        let selected = notification.object as! Bool
        if selected {
            
        }
    }
    
    // 添加子控制器
    private func addChildViewControllers() {
        setChildViewController(HomeViewController(), title: "首页", imageName: "home_tabbar_32x32_", selectedImageName: "home_tabbar_press_32x32_")
        setChildViewController(VideoViewController(), title: "视频", imageName: "video_tabbar_32x32_", selectedImageName: "video_tabbar_press_32x32_")
        setChildViewController(HuoshanViewController(), title: "小视频", imageName: "huoshan_tabbar_32x32_", selectedImageName: "huoshan_tabbar_press_32x32_")
        setChildViewController(MineViewController(), title: "我的", imageName: "mine_tabbar_32x32_", selectedImageName: "mine_tabbar_press_32x32_")
    }

    // 初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String, selectedImageName: String ) {
        // 设置文字和图片
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        // 设置导航栏的文字
        childController.title = title
        // 添加导航控制器为 TabBarController 的子控制器
        let navVC = MyNavigationController(rootViewController: childController)
        addChild(navVC)
    }
}
