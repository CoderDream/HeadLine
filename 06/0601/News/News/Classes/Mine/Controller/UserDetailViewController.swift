//
//  UserDetailViewController.swift
//  News
//
//  Created by CoderDream on 2019/5/10.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewBottom: NSLayoutConstraint!
    // 隐藏导航栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        scrollView.addSubview(headerView)
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: 1000)
        
        // 判断设置型号，设置约束，避免 bottomView 顶到边界
        bottomViewBottom.constant = isIPhoneX ? 34 : 0
        //
        view.layoutIfNeeded()
    }
    
    /// 懒加载
    lazy var headerView: UserDetailHeaderView = {
        let headerView = UserDetailHeaderView.headerView()
        return headerView
    }()
    
    // 更改颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
