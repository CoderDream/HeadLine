//
//  MineViewController.swift
//  News
//
//  Created by CoderDream on 2019/4/15.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MineViewController: UITableViewController {
    
    fileprivate let disposeBag = DisposeBag()
    // 存储 cell 的数据  这里不能声明为可选类型，否则程序会崩溃
    var sections = [[MyCellModel]]()
    // 存储我的关注数据
    var concerns = [MyConcern]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {        
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        
        //
        tableView.tableHeaderView = headerView
        
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        // 去掉系统默认的分割线
        tableView.separatorStyle = .none
        // 注册自定义 Cell
        tableView.ymRegisterCell(cell: MyFirstSectionCell.self)
        tableView.ymRegisterCell(cell: MyOtherCell.self)
        //tableView.register(UINib(nibName: String(describing: MyFirstSectionCell.self), bundle: nil),
        //                   forCellReuseIdentifier: String(describing: MyFirstSectionCell.self))
        //tableView.register(UINib(nibName: String(describing: MyOtherCell.self), bundle: nil),
        //                   forCellReuseIdentifier: String(describing: MyOtherCell.self))
//        tableView.sectionHeaderHeight = UITableView.automaticDimension + 50
//        tableView.rowHeight = UITableView.automaticDimension + 50
//        tableView.sectionFooterHeight = UITableView.automaticDimension + 50
        //
        NetworkTool.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.sections.append(myConcerns)
            self.sections += sections
            self.tableView.reloadData()
            //
            NetworkTool.loadMyConcern(completionHandler: { (concerns) in
                self.concerns = concerns
                let indexSet = IndexSet(integer: 0)
                self.tableView.reloadSections(indexSet, with: .automatic)
            })
        }
        
        //headerView.more
        headerView.moreLoginButton.rx.controlEvent(UIControlEvents.touchUpInside)
            .subscribe(onNext: { [weak self] in
                let storyboard = UIStoryboard(name: String(describing: MoreLoginViewController.self), bundle: nil)
                let moreLoginVC = storyboard.instantiateViewController(withIdentifier: String(describing: MoreLoginViewController.self)) as! MoreLoginViewController
                moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(SCREEN_HEIGHT - (isIPhoneX ? 44 : 20))))
                self!.present(moreLoginVC, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    fileprivate lazy var headerView: NoLoginHeaderView = {
        let headerView = NoLoginHeaderView.headerView()
        return headerView
    }()
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
        
        if indexPath.section == 0 && indexPath.row == 0 {
            //let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyFirstSectionCell.self)) as! MyFirstSectionCell
            let cell = tableView.ymDequeueReusableCell(indexPath: indexPath) as MyFirstSectionCell
            
            let section = sections[indexPath.section]
            cell.myCellModel = section[indexPath.row]
            //let myCellModel = section[indexPath.row]
            // 自定义属性
            //cell.leftLabel?.text = myCellModel.text
            //cell.rightLabel?.text = myCellModel.grey_text
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
        //固定高度
//        if indexPath.section == 0 {
//            tableView.sectionHeaderHeight = UITableView.automaticDimension + 50
//            tableView.rowHeight = UITableView.automaticDimension + 50
//            tableView.sectionFooterHeight = UITableView.automaticDimension + 50
//            return 100
//        } else {
//            return UITableView.automaticDimension + 50
//        }
        //if indexPath.section > 0 {
        //    return UITableView.automaticDimension + 50
        //}
        
        
       //return UITableView.automaticDimension + 50
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        } else {
            return 40
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = kMyHeaderViewHeight + abs(offsetY)
            // 偏移比例
            let f = totalOffset / kMyHeaderViewHeight
            headerView.bgImageView.frame = CGRect(x: -SCREEN_WIDTH * (f - 1) * 0.5, y: offsetY, width: SCREEN_WIDTH * f, height: totalOffset)
            
        }
    }
}
