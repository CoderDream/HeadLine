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
                //print("clicked loadCacheSize")
                calculateDiskCacheSize(cell)
            case 2: // 摘要 没有点击效果
                cell.selectionStyle = .none
            default:
                break
            }
            
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        // 去掉默认的点击效果
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: // 清理缓存
                // 弹出清理缓存的提示框
                clearCacheAlertController(cell)
            case 1: // 设置字体大小
                setunFontAlertController(cell)
            case 3: // 设置非 WIFI 网络流量
                setupNetworkAlertController(cell)
            case 4: // 非 WIFI 网络播放提醒
                setupPlayNoticeAlertController(cell)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0: // 离线下载
                let offlineDownloadViewController = OfflineDownloadViewController()
                offlineDownloadViewController.navigationItem.title = "离线下载"
                navigationController?.pushViewController(offlineDownloadViewController, animated: true)
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
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


extension SettingViewController {
    /// 非 WIFI 网络播放提醒
    fileprivate func setupPlayNoticeAlertController(_ cell: SettingCell) {
        let alertController = UIAlertController(title: "非 WIFI 网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everyAction = UIAlertAction(title: "每次提醒", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "每次提醒"
        })
        let onceAction = UIAlertAction(title: "提醒一次", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "提醒一次"
        })
        alertController.addAction(cancelAction)
        alertController.addAction(onceAction)
        alertController.addAction(everyAction)
        present(alertController, animated: true, completion: nil)
    }
    /// 设置非 WIFI 网络流量
    fileprivate func setupNetworkAlertController(_ cell: SettingCell) {
        let alertController = UIAlertController(title: "非 WIFI 网络流量", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let bestAction = UIAlertAction(title: "最佳效果（下载大图）", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "最佳效果（下载大图）"
        })
        let betterAction = UIAlertAction(title: "较省流量（智能下图）", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "较省流量（智能下图）"
        })
        let leastAction = UIAlertAction(title: "极省流量（智能下图）", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "极省流量（智能下图）"
        })
        alertController.addAction(cancelAction)
        alertController.addAction(bestAction)
        alertController.addAction(betterAction)
        alertController.addAction(leastAction)
        present(alertController, animated: true, completion: nil)
    }
    /// 设置字体大小
    fileprivate func setunFontAlertController(_ cell: SettingCell) {
        let alertController = UIAlertController(title: "设置字体大小", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let smallAction = UIAlertAction(title: "小", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "小"
        })
        let middleAction = UIAlertAction(title: "中", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "中"
        })
        let bigAction = UIAlertAction(title: "大", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "大"
        })
        let largeAction = UIAlertAction(title: "特大", style: .default, handler: { (_) in
            cell.rightTitleLabel.text = "特大"
        })
        alertController.addAction(cancelAction)
        alertController.addAction(smallAction)
        alertController.addAction(middleAction)
        alertController.addAction(bigAction)
        alertController.addAction(largeAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// 从沙盒中获取缓存数据大小
    fileprivate func calculateDiskCacheSize(_ cell: SettingCell) {
        print("calculateDiskCacheSize")
        
        let cache = KingfisherManager.shared.cache
        //        cache.calculateDiskCacheSize { (size) in
        //            // 转换成 M
        //            let sizeM = Double(size) / 1024.0 / 1024.0
        //            self.rightTitleLabel.text = String(format: "%.2fM", sizeM)
        //        }
        cache.calculateDiskStorageSize(completion: {
            let temp = $0.value
            print("value: \(String(describing: temp))")
            let sizeM = Double($0.value ?? 0) / 1024.0 / 1024.0
            let sizeString = String(format: "%.00M", sizeM)
            print("sizeString: \(sizeString)")
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cacheSize"), object: self, userInfo: ["cacheSize": sizeString])
            cell.rightTitleLabel.text = String(format: "%.2fM", sizeM)
        })
    }
    /// 弹出清理缓存的提示框
    fileprivate func clearCacheAlertController(_ cell: SettingCell) {
        let alertController = UIAlertController(title: "确定清除所有缓存？问答、草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            cache.cleanExpiredDiskCache()
            cell.rightTitleLabel.text = "0.00M"
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
        sections = cellPlist.compactMap({ section in
            (section as! [Any]).compactMap({ row in
                SettingModel.deserialize(from: row as? NSDictionary)
            })
        })
        tableView.ymRegisterCell(cell: SettingCell.self)
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        // 设置系统的分割线为空
        tableView.separatorStyle = .none
        // 更新主题
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
    }
}
