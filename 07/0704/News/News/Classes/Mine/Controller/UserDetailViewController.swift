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
    var userId: Int = 0
    var userDetail: UserDetail?
    
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
        // 调用接口
        NetworkTool.loadUserDetail(user_id: userId) { (userDetail) in
            self.userDetail = userDetail
            self.headerView.userDetail = userDetail
            if userDetail.bottom_tab.count == 0 {
                self.bottomViewBottom.constant = 0
                self.view.layoutIfNeeded()
            } else {
                // 赋值到 bottomView 上
                self.bottomView.addSubview(self.myBottomView)
                self.myBottomView.bottomTabs = userDetail.bottom_tab
            }
        }
    }
    
    /// 懒加载
    fileprivate lazy var headerView: UserDetailHeaderView = {
        //let headerView = UserDetailHeaderView.headerView()
        let headerView = UserDetailHeaderView.loadViewFromNib()
        return headerView
    }()
    
    /// 懒加载
    fileprivate lazy var myBottomView: UserDetailBottomView = {
        let myBottomView = UserDetailBottomView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        // 设置代理
        myBottomView.delegate = self
        return myBottomView
    }()
    
    // 更改颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension UserDetailViewController: UserDetailBottomViewDelegate {
    // bottomView 底部按钮的点击
    func bottomView(clicked button: UIButton, bottomTab: BottomTab) {
        let bottomPushVC = UserDetailBottomPushController()
        bottomPushVC.navigationItem.title = "网页浏览"
        if bottomTab.children.count == 0 { // 直接跳转到下一控制器
            bottomPushVC.url = bottomTab.value
            navigationController?.pushViewController(bottomPushVC, animated: true)
        } else { // 弹出子视图
            let sb = UIStoryboard(name: "\(UserDetailBottomPopController.self)", bundle: nil)
            let popoverVC = sb.instantiateViewController(withIdentifier: "\(UserDetailBottomPopController.self)") as! UserDetailBottomPopController
            popoverVC.children1 = bottomTab.children
            // 转场动画
            popoverVC.modalPresentationStyle = .custom
            let popoverAnimator = PopoverAnimator()
            popoverVC.transitioningDelegate = popoverAnimator
            present(popoverVC, animated: true, completion: nil)
        }
    }
    
    
}
