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
    
    // ---------------------------- 首页 Home ----------------------------------
    // 首页顶部新闻标题的数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    
    // ---------------------------- 我的 mine ----------------------------------
    // 我的界面 cell 的数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ())
    // 我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ sections: [MyConcern]) -> ())
}

extension NetworkToolProtocol {
    // 首页顶部新闻标题的数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()) {
        print("loadHomeNewsTitleData")
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id, "iid": iid]
        Alamofire.request(url, method: .get, parameters: params).responseJSON{ (response) in
            guard response.result.isSuccess else {
                // 网络错误的提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let dataData = json["data"].dictionary {
                    if let data = dataData["data"]?.arrayObject {
                        print("loadHomeNewsTitleData.data \(data)")
                        var titles = [HomeNewsTitle]()
                        let jsonString = "{\"category\": \"\", \"name\": \"推荐\"}"
                        let recommend = HomeNewsTitle.deserialize(from: jsonString)
                        titles.append(recommend!)
                        for item in data {
                            let newsTitle = HomeNewsTitle.deserialize(from: item as? NSDictionary)
                            titles.append(newsTitle!)
                        }
                        completionHandler(titles)
                    }
                }
            }
        }
    }
    
    // ---------------------------- 我的 mine ----------------------------------
    // 我的界面 cell 的数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ()) {
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id": device_id]
        Alamofire.request(url, method: .get, parameters: params).responseJSON{ (response) in
            guard response.result.isSuccess else {
                // 网络错误的提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    print(data)
                    if let sections = data["sections"]?.array {
                        var sectionArray = [[MyCellModel]]()
                        for item in sections {
                            var rows = [MyCellModel]()
                            for row in item.arrayObject! {
                                let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
                                rows.append(myCellModel!)
                            }
                            sectionArray.append(rows)
                        }
                        completionHandler(sectionArray)
                    }
                }
            }
        }
    }
    // 我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ sections: [MyConcern]) -> ()) {
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        Alamofire.request(url, method: .get, parameters: params).responseJSON{ (response) in
            guard response.result.isSuccess else {
                // 网络错误的提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let datas = json["data"].arrayObject {
                    //print(datas)
                    var concerns = [MyConcern]()
                    for data in datas {
                        let myConcern = MyConcern.deserialize(from: data as? NSDictionary)
                        concerns.append(myConcern!)
                    }
                    completionHandler(concerns)
                }
            }
        }
    }
}


struct NetworkTool: NetworkToolProtocol {
    
}
