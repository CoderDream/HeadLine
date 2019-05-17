//
//  HomeViewController.swift
//  News
//
//  Created by CoderDream on 2019/4/15.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // 标题数据表
    fileprivate let newsTitleTable = NewsTitleTable()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.blue
        
        
        
        NetworkTool.loadHomeNewsTitleData { (titles) in
            // 向数据库中插入数据
            self.newsTitleTable.insert(titles)
        }
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
