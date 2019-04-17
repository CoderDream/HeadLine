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
    
    var concerns = [MyConcern]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        // 使用注册方式的 TableCell
        //tableView.register(UINib(nibName: String(describing: MyFirstSectionCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyFirstSectionCell.self))
        //tableView.register(UINib(nibName: String(describing: MyOtherCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyOtherCell.self))
        tableView.ymRegisterCell(cell: MyFirstSectionCell.self)
        tableView.ymRegisterCell(cell: MyOtherCell.self)
        // 获取我的 cell 的数据
        NetworkTool.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections
            self.tableView.reloadData()
            
            NetworkTool.loadMyConcern(completionHandler: { (concerns) in
                self.concerns = concerns
                let indexSet = IndexSet(integer: 0)
                self.tableView.reloadSections(indexSet, with: .automatic)
                })
        }
    }
}

extension MineViewController {
    // 每组头部的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // 每组头部视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        view.backgroundColor = UIColor.globalBackgroundColor()
        return view
    }
    // 设置每行的高度
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        return 40
    }
    
    // 组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // 每组的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    // cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            //let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyFirstSectionCell.self)) as! MyFirstSectionCell
            let cell = tableView.ymDequeueReusableCell(indexPath: indexPath) as MyFirstSectionCell
            let section = sections[indexPath.section]
            let myCellModel = section[indexPath.row]
            cell.myCellModel = section[indexPath.row]
            //cell.leftLabel.text = myCellModel.text
            //cell.rightLabel.text = myCellModel.grey_text
            if concerns.count == 0 || concerns.count == 1 {
                cell.collectionView.isHidden = true
            }
            if concerns.count == 1 {
                cell.myConcern = concerns[0]
            }
            if concerns.count > 1 {
                cell.myConcerns = concerns
            }
            return cell
        }
        //let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyOtherCell.self)) as! MyOtherCell
        let cell = tableView.ymDequeueReusableCell(indexPath: indexPath) as MyOtherCell
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
        cell.leftLabel.text = myCellModel.text
        cell.rightLabel.text = myCellModel.grey_text
        return cell
    }
    
    // 去掉点击 Cell 产生的阴影
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
