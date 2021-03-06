//
//  OfflineDownloadViewController.swift
//  News
//
//  Created by CoderDream on 2019/5/8.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class OfflineDownloadViewController: UITableViewController {
    // 标题数组
    fileprivate var titles = [HomeNewsTitle]()
    // 标题数据表
    fileprivate let newsTitleTable = NewsTitleTable()

    override func viewDidLoad() {
        //print("OfflineDownloadViewController.viewDidLoad")
        super.viewDidLoad()
        tableView.ymRegisterCell(cell: OfflineDownloadCell.self)
        tableView.rowHeight = 44
        tableView.theme_separatorColor = "colors.separatorViewColor"
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        //

        // 从数据库中取出所有数据，赋值给 标题数组 titles
        titles = newsTitleTable.selectAll()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        // 标签
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: SCREEN_WIDTH, height: 44))
        label.text = "我的频道"
        label.theme_textColor = "colors.black"
        // 分割线
        let separatorView  = UIView(frame: CGRect(x: 0, y: 43, width: SCREEN_WIDTH, height: 1))
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        
        view.addSubview(label)
        view.addSubview(separatorView)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ymDequeueReusableCell(indexPath: indexPath) as OfflineDownloadCell
        let newsTitle = titles[indexPath.row]
        cell.titleLabel.text = newsTitle.name
        cell.rightImageView.theme_image = newsTitle.selected ? "images.air_download_option_press" : "images.air_download_option"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取出数组中的第 row 个对象
        var homeNewsTitle = titles[indexPath.row]
        // 取反
        homeNewsTitle.selected = !homeNewsTitle.selected
        // 取出第 row 个 Cell
        let cell = tableView.cellForRow(at: indexPath) as! OfflineDownloadCell
        // 改变 cell 中的图片
        cell.rightImageView.theme_image = homeNewsTitle.selected ? "images.air_download_option_press" : "images.air_download_option"
        // 替换数组中的数据
        titles[indexPath.row] = homeNewsTitle
        // 更新数据库中的数据
        newsTitleTable.update(homeNewsTitle)
        // 更新页面中的 Cell
        tableView.reloadRows(at: [indexPath], with: .none)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
