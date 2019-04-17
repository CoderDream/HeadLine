//
//  NetworkTool.swift
//  News
//
//  Created by CoderDream on 2019/4/16.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
    // ---------------------------- 我的 mine ----------------------------------
    // 我的界面 cell 的数据
    static func loadMyCellData()
    // 我的关注数据
    static func loadMyConcern()
}

extension NetworkToolProtocol {
    // ---------------------------- 我的 mine ----------------------------------
    // 我的界面 cell 的数据
    static func loadMyCellData() {
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id": device_id]
        Alamofire.request(url, method: .get, parameters: params).responseJSON{ (response) in
            guard response.result.isSuccess else {
                
              return
            }
        }
        
    }
    // 我的关注数据
    static func loadMyConcern() {
        
    }
}


struct NetworkTool: NetworkToolProtocol {
    
}
