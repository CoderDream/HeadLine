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
    }
    
    /// 懒加载
    lazy var headerView: UserDetailHeaderView = {
        let headerView = UserDetailHeaderView.headerView()
        return headerView
    }()

}
