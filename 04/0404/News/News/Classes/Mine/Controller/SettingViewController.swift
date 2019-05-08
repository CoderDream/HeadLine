//
//  TableViewController.swift
//  News
//
//  Created by CoderDream on 2019/5/7.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import Kingfisher

class SettingViewController: UITableViewController {
    
    /// 存储 plist 文件中的数据
    var sections = [[SettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI
        setupUI()
        calculateDiskCacheSize()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let rows = sections[section]
        return rows.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ymDequeueReusableCell(indexPath: indexPath) as SettingCell
        let rows = sections[indexPath.section]
        cell.setting = rows[indexPath.row]
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: // 清理缓存
                NotificationCenter.default.addObserver(self, selector: #selector(loadCacheSize),
                                                       name: NSNotification.Name(rawValue: "cacheSizeM"), object: nil)
            case 1: // 设置字体
                NotificationCenter.default.addObserver(self, selector: #selector(changeFontSize),
                                                       name: NSNotification.Name(rawValue: "fontSize"), object: nil)
            case 2: // 摘要 没有点击效果
                cell.selectionStyle = .none
            case 3: // 设置非 WIFI 网络流量
                NotificationCenter.default.addObserver(self, selector: #selector(changeNetworkMode),
                                                       name: NSNotification.Name(rawValue: "networkMode"), object: nil)
            case 4: // 非 WIFI 网络播放提醒
                NotificationCenter.default.addObserver(self, selector: #selector(changeNetworkMode),
                                                       name: NSNotification.Name(rawValue: "playNotice"), object: nil)
            default:
                break
            }
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 去掉默认的点击效果
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: // 清理缓存
                // 弹出清理缓存的提示框
                clearCacheAlertController()
            case 1: // 设置字体大小
                setunFontAlertController()
            case 3: // 设置非 WIFI 网络流量
                setupNetworkAlertController()
            case 4: // 非 WIFI 网络播放提醒
                setupPlayNoticeAlertController()
            default:
                break
            }
            
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        //view.backgroundColor = UIColor.globalBackgroundColor()
        // 更新主题
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
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


extension SettingViewController {
    
    /// 非 WIFI 网络流量
    @objc fileprivate func changePlayNotice(notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = IndexPath(row: 4, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.rightTitleLabel.text = userInfo["playNotice"] as? String
    }
    /// 非 WIFI 网络播放提醒
    fileprivate func setupPlayNoticeAlertController() {
        let alertController = UIAlertController(title: "非 WIFI 网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everyAction = UIAlertAction(title: "每次提醒", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playNotice"), object: self, userInfo: ["playNotice": "每次提醒"])
        })
        let onceAction = UIAlertAction(title: "提醒一次", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playNotice"), object: self, userInfo: ["playNotice": "提醒一次"])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(onceAction)
        alertController.addAction(everyAction)
        present(alertController, animated: true, completion: nil)
    }
    /// 非 WIFI 网络流量
    @objc fileprivate func changeNetworkMode(notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.rightTitleLabel.text = userInfo["networkMode"] as? String
    }
    /// 设置非 WIFI 网络流量
    fileprivate func setupNetworkAlertController() {
        let alertController = UIAlertController(title: "非 WIFI 网络流量", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestAction = UIAlertAction(title: "最佳效果（下载大图）", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "networkMode"), object: self, userInfo: ["networkMode": "最小效果（下载大图）"])
        })
        let betterAction = UIAlertAction(title: "较省流量（智能下图）", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "networkMode"), object: self, userInfo: ["networkMode": "较省流量（智能下图）"])
        })
        let leastAction = UIAlertAction(title: "极省流量（智能下图）", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "networkMode"), object: self, userInfo: ["networkMode": "极省流量（智能下图）"])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(bestAction)
        alertController.addAction(betterAction)
        alertController.addAction(leastAction)
        present(alertController, animated: true, completion: nil)
    }
    /// 改变字体大小
    @objc fileprivate func changeFontSize(notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.rightTitleLabel.text = userInfo["fontSize"] as? String
    }
    /// 设置字体大小
    fileprivate func setunFontAlertController() {
        let alertController = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "小"])
        })
        let middleAction = UIAlertAction(title: "中", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "中"])
        })
        let bigAction = UIAlertAction(title: "大", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "大"])
        })
        let largeAction = UIAlertAction(title: "特大", style: .default, handler: { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fontSize"), object: self, userInfo: ["fontSize": "特大"])
        })
        alertController.addAction(cancelAction)
        alertController.addAction(smallAction)
        alertController.addAction(middleAction)
        alertController.addAction(bigAction)
        alertController.addAction(largeAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// 从沙盒中获取缓存数据大小
    fileprivate func calculateDiskCacheSize() {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            // 转换成 M（兆）
            let sizeM = Double(size) / 1024.0 / 1024.0
            let sizeString = String(format: "%.0M", sizeM)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cacheSizeM"), object: self, userInfo: ["cacheSize": sizeString])
        }
    }
    /// 获取缓存大小显示到 Cell
    @objc fileprivate func loadCacheSize(notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.rightTitleLabel.text = userInfo["cacheSize"] as? String
    }
    /// 弹出清理缓存的提示框
    fileprivate func clearCacheAlertController() {
        let alertController = UIAlertController(title: "确定清除所有缓存？问答、草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            let sizeString = "0.00M"
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cacheSizeM"), object: self, userInfo: ["cacheSize": sizeString])
            })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension SettingViewController {
    /// 设置 UI
    fileprivate func setupUI() {
        // plist 文件的路径
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        for ditcs in cellPlist {
            let array = ditcs as! [[String: Any]]
            var rows = [SettingModel]()
            for dict in array {
                let setting = SettingModel.deserialize(from: dict as NSDictionary)
                rows.append(setting!)
            }
            sections.append(rows)
        }
        tableView.ymRegisterCell(cell: SettingCell.self)
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        // 设置系统的分割线为空
        tableView.separatorStyle = .none
        // 更新主题
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
    }
}
