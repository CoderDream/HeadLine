//
//  MoreLoginViewController.swift
//  News
//
//  Created by CoderDream on 2019/5/6.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import IBAnimatable

class MoreLoginViewController: AnimatableModalViewController {
    /// 顶部标题
    @IBOutlet weak var topLabel: UILabel!
    /// 手机号 View
    @IBOutlet weak var mobileView: AnimatableView!
    /// 验证码 View
    @IBOutlet weak var passwordView: AnimatableView!
    /// 发送验证码 View
    @IBOutlet weak var sendVerifyView: UIView!
    /// 找回密码 View
    @IBOutlet weak var findPasswordView: UIView!
    /// 发送验证码 按钮
    @IBOutlet weak var sendVerifyButton: UIButton!
    /// 手机号 输入框
    @IBOutlet weak var mobileTextField: UITextField!
    /// 找回密码 按钮
    @IBOutlet weak var findPasswordButton: UIButton!
    /// 密码 输入框
    @IBOutlet weak var passwordTextField: UITextField!
    /// 未注册
    @IBOutlet weak var middleTipLabel: UILabel!
    /// 进入头条
    @IBOutlet weak var enterTouTiaoButton: AnimatableButton!
    /// 阅读条款
    @IBOutlet weak var readLabel: UILabel!
    /// 阅读按钮
    @IBOutlet weak var readButton: UIButton!
    /// 账号密码登录
    @IBOutlet weak var loginModeButton: UIButton!
    /// 账号密码登录 点击
    @IBAction func loginModeButtonClicked(_ sender: UIButton) {
        loginModeButton.isSelected = !sender.isSelected
        
        sendVerifyView.isHidden = sender.isSelected
        findPasswordView.isHidden = !sender.isSelected
        middleTipLabel.isHidden = sender.isSelected
        passwordTextField.placeholder = sender.isSelected ? "密码" : "请输入验证码"
        topLabel.text = sender.isSelected ? "账号密码登录" : "登录你的头条，精彩永不消失"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        loginModeButton.setTitle("免密码登录", for: .selected)
    }
    
    @IBAction func moreLoginCloseButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
