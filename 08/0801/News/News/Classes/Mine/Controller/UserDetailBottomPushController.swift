//
//  UserDetailBottomPushController.swift
//  News
//
//  Created by CoderDream on 2019/5/18.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import WebKit

class UserDetailBottomPushController: UIViewController {
    
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView()
        webView.frame = view.bounds
        webView.load(URLRequest(url: URL(string: url!)!))
        view.addSubview(webView)
    }
    
    // 显示导航栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
