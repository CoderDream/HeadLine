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
    
    /// 改变状态栏的字体颜色
    var changeStatusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        // 设置代理
        scrollView.delegate = self
        scrollView.addSubview(headerView)
        // 添加导航栏
        scrollView.addSubview(navigationBar)
        // 返回按钮
        navigationBar.goBackButtonClicked = {
            self.navigationController?.popViewController(animated: true)
        }
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: 1000)
        
        // 判断设置型号，设置约束，避免 bottomView 顶到边界
        bottomViewBottom.constant = isIPhoneX ? 34 : 0
        //
        view.layoutIfNeeded()
        // 调用接口
        NetworkTool.loadUserDetail(user_id: userId) { (userDetail) in
            self.userDetail = userDetail
            self.headerView.userDetail = userDetail
            // 设置导航栏
            self.navigationBar.userDetail = userDetail
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
    
    /// 懒加载 头部
    fileprivate lazy var headerView: UserDetailHeaderView = {
        //let headerView = UserDetailHeaderView.headerView()
        let headerView = UserDetailHeaderView.loadViewFromNib()
        return headerView
    }()
    
    /// 懒加载 底部
    fileprivate lazy var myBottomView: UserDetailBottomView = {
        let myBottomView = UserDetailBottomView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        // 设置代理
        myBottomView.delegate = self
        return myBottomView
    }()
    
    /// 懒加载 导航栏
    fileprivate lazy var navigationBar: NavigationBarView = {
        let navigationBar = NavigationBarView.loadViewFromNib()
        return navigationBar
    }()
    
    // 更改颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UserDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        // 图片黏住顶部，拉伸 iPhone X -44
        if offsetY < -44 {
            let totalOffset = kUserDetailHeaderBGImageViewHeight + abs(offsetY)
            let f = totalOffset / kUserDetailHeaderBGImageViewHeight
            headerView.backgroundImageView.frame = CGRect(x: -SCREEN_WIDTH * (f - 1) * 0.5, y: offsetY, width: SCREEN_WIDTH * f, height: totalOffset)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        } else {
            var alpha: CGFloat = (offsetY + 44) / 58
            alpha = min(alpha, 1.0)
            navigationBar.backgroundColor = UIColor(white: 1.0, alpha: alpha)
            if alpha == 1.0 {
                changeStatusBarStyle = .default
                navigationBar.returnButton.theme_setImage("images.personal_home_back_black_24x24_", forState: .normal)
                navigationBar.moreButton.theme_setImage("images.new_more_titlebar_24x24_", forState: .normal)
            } else {
                changeStatusBarStyle = .lightContent
                navigationBar.returnButton.theme_setImage("images.personal_home_back_white_24x24_", forState: .normal)
                navigationBar.moreButton.theme_setImage("images.new_morewhite_titlebar_22x22_", forState: .normal)
            }
            var alpha1: CGFloat = offsetY / 57
            // 14 + 15 + 14
            if offsetY >= 43 {
                alpha1 = min(alpha1, 1.0)
                navigationBar.nameLabel.isHidden = false
                navigationBar.concernButton.isHidden = false
                navigationBar.nameLabel.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: alpha1)
                navigationBar.concernButton.alpha = alpha1
            } else {
                alpha1 = min(0.0, alpha1)
                navigationBar.nameLabel.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: alpha1)
                navigationBar.concernButton.alpha = alpha1
            }
        }
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
            popoverVC.didSelectedChild = {
                bottomPushVC.url = $0.value
                self.navigationController?.pushViewController(bottomPushVC, animated: true)
            }
            let popoverAnimator = PopoverAnimator()
            // 转化 frame
            let rect = myBottomView.convert(button.frame, to: view)
            let popWidth = (SCREEN_WIDTH - CGFloat(userDetail!.bottom_tab.count + 1) * 20) / CGFloat(userDetail!.bottom_tab.count)
            let popX = CGFloat(button.tag) * (popWidth + 20) + 20
            let popHeight = CGFloat(bottomTab.children.count) * 40  + 25
            popoverAnimator.presetnFrame = CGRect(x: popX, y: rect.origin.y - popHeight, width: popWidth, height: popHeight)
                        
            popoverVC.transitioningDelegate = popoverAnimator
            present(popoverVC, animated: true, completion: nil)
        }
    }
    
    
}
