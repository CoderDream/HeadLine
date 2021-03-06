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
import SVProgressHUD

protocol NetworkToolProtocol {
    
    // ---------------------------- 首页 Home ----------------------------------
    /// 首页顶部新闻标题的数据
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    
    // ---------------------------- 我的 mine ----------------------------------
    /// 我的界面 cell 的数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ())
    /// 我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ sections: [MyConcern]) -> ())
    /// 获取用户详情数据
    static func loadUserDetail(user_id: Int, completionHandler: @escaping (_ userDetail: UserDetail) -> ())
    /// 已关注用户，取消关注
    static func loadRelationUnfollow(user_id: Int, completionHandler: @escaping (_ user: ConcernUser) -> ())
    /// 点击关注按钮，关注用户
    static func loadRelationFollow(user_id: Int, completionHandler: @escaping (_ user: ConcernUser) -> ())    
    /// 点击了关注按钮，就会出现相关推荐数据
    static func loadRelationUserRecommend(user_id: Int, completionHandler: @escaping (_ userCard: [UserCard]) -> ())
}

extension NetworkToolProtocol {
    /// 首页顶部新闻标题的数据
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
    /// 我的界面 cell 的数据
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
                    if let sections = data["sections"]?.arrayObject {
//                        var sectionArray = [[MyCellModel]]()
//                        for item in sections {
//                            var rows = [MyCellModel]()
//                            for row in item.arrayObject! {
//                                let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
//                                rows.append(myCellModel!)
//                            }
//                            sectionArray.append(rows)
//                        }
                        // map 替换 for
                        let sectionArray = sections.compactMap({ item in
                            (item as! [Any]).compactMap({ row in
                                MyCellModel.deserialize(from: row as? NSDictionary)
                            })
                        })
                        
                        completionHandler(sectionArray)
                    }
                }
            }
        }
    }
    /// 我的关注数据
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
//                    var concerns = [MyConcern]()
//                    for data in datas {
//                        let myConcern = MyConcern.deserialize(from: data as? NSDictionary)
//                        concerns.append(myConcern!)
//                    }
                    // map 替换 for
                    let concerns = datas.compactMap({
                        MyConcern.deserialize(from: $0 as? NSDictionary)
                    })
                    
                    completionHandler(concerns)
                }
            }
        }
    }
    /// 获取用户详情数据
    static func loadUserDetail(user_id: Int, completionHandler: @escaping (_ userDetail: UserDetail) -> ()) {
        let url = BASE_URL + "/user/profile/homepage/v4/?"
        let params = ["user_id": user_id,
                      "device_id": device_id,
                      "iid": iid]
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
                if let data = json["data"].dictionaryObject {
                    //print(datas)
                    let userDetail = UserDetail.deserialize(from: data as NSDictionary)
                    completionHandler(userDetail!)
                }
            }
        }
    }
    /// 已关注用户，取消关注
    static func loadRelationUnfollow(user_id: Int, completionHandler: @escaping (_ user: ConcernUser) -> ()) {
        let url = BASE_URL + "/2/relation/unfollow/?"
        let params = ["user_id": user_id,
                      "device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, method: .get, parameters: params).responseJSON{ (response) in
            guard response.result.isSuccess else {
                // 网络错误的提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    if let data = json["data"].dictionaryObject {
                        SVProgressHUD.showInfo(withStatus: data["description"] as? String)
                        SVProgressHUD.setForegroundColor(UIColor.white)
                        SVProgressHUD.setBackgroundColor(UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3))
                    }
                    return
                }
                if let data = json["data"].dictionaryObject {
                    //print(datas)
                    let user = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandler(user!)
                }
            }
        }
    }
    /// 点击关注按钮，关注用户
    static func loadRelationFollow(user_id: Int, completionHandler: @escaping (_ user: ConcernUser) -> ()) {
        let url = BASE_URL + "/2/relation/follow/v2/?"
        let params = ["user_id": user_id,
                      "device_id": device_id,
                      "iid": iid]
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
                if let data = json["data"].dictionaryObject {
                    //print(datas)
                    let user = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandler(user!)
                }
            }
        }
    }
    /// 点击了关注按钮，就会出现相关推荐数据
    static func loadRelationUserRecommend(user_id: Int, completionHandler: @escaping (_ userCard: [UserCard]) -> ()) {
        let url = BASE_URL + "/user/relation/user_recommend/v1/supplement_recommends/?"
        let params = ["follow_user_id": user_id,
                      "device_id": device_id,
                      "iid": iid,
                      "scene": "follow",
        "source": "follow"] as [String: Any]
        Alamofire.request(url, method: .get, parameters: params).responseJSON{ (response) in
            guard response.result.isSuccess else {
                // 网络错误的提示信息
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["err_no"] == 0 else {
                    return
                }
                if let user_cards = json["user_cards"].arrayObject {
                    let user = user_cards.compactMap({
                        UserCard.deserialize(from: $0 as? NSDictionary)
                    })
                    
                    completionHandler(user)
                }
            }
        }
    }
}


struct NetworkTool: NetworkToolProtocol {
    
}
