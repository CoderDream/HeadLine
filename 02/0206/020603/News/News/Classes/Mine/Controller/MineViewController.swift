//
//  MineViewController.swift
//  News
//
//  Created by CoderDream on 2019/4/15.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {
    // 这里不能声明为可选类型，否则程序会崩溃
    var sections = [[MyCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        // 去掉系统默认的分割线
        tableView.separatorStyle = .none
        // 注册自定义 Cell
        tableView.register(UINib(nibName: String(describing: MyOtherCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyOtherCell.self))
        // 
        NetworkTool.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections
            self.tableView.reloadData()
        }
    }
}

extension MineViewController {
    // 每组头部的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //return 10
        return section == 1 ? 0 : 10
    }
    // 每组头部视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    // 组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    // 每组的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyOtherCell.self)) as! MyOtherCell
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
        //cell.textLabel?.text = myCellModel.text
        // 自定义属性
        cell.leftLabel?.text = myCellModel.text
        cell.rightLabel?.text = myCellModel.grey_text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("didSelectRowAt: \(indexPath)")
    }
    // 设置高度
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 固定高度
//        if indexPath.section == 0 {
//            return 100
//        } else {
//            return UITableView.automaticDimension + 50
//        }
        //if indexPath.section > 0 {
        //    return UITableView.automaticDimension + 50
        //}
        
        return UITableView.automaticDimension + 50
        
    }
}
