//
//  UserDetailBottomPopController.swift
//  News
//
//  Created by CoderDream on 2019/5/18.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class UserDetailBottomPopController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var children1 = [BottomTabChildren]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var didSelectedChild: ((BottomTabChildren)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.selectionStyle = .none
        let child = children1[indexPath.row]
        cell.textLabel?.text = child.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MyPresentationControllerDismiss), object: nil)
        didSelectedChild?(children1[indexPath.row])
    }
}
