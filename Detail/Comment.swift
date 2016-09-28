//
//  Comment.swift
//  图书展示
//
//  Created by 陈楠 on 16/8/17.
//  Copyright © 2016年 chennan. All rights reserved.
//

import UIKit

class Comment: NSObject {

    var id = 0
    var title = ""
    var alt = "" //html格式，评论详情url
    var cName = Author()
    var rating:Score!
    var votes = 0
    var useless = 0
    var commentNum = 0
    var summary = "" //评论摘要
    var cDate = ""  //评论时间
    var update = "" //上次评论时间
    
    init(dict:[String : NSObject]){
    
        id = dict["id"] as? Int ?? 0
        title = dict["title"] as? String ?? ""
        alt = dict["alt"] as? String ?? ""
        if let comName = dict["author"] as? [String:NSObject]{
            cName = Author(dict:comName)
        }
        if let scoreDict = dict["rating"] as? [String:NSObject]{
            rating = Score(dict:scoreDict)
        }
        votes = dict["votes"] as? Int ?? 0
        useless = dict["useless"] as? Int ?? 0
        commentNum = dict["commnets"] as? Int ?? 0
        summary = dict["summary"] as? String ?? ""
        cDate = dict["published"] as? String ?? ""
        update = dict["updated"] as? String ?? ""
        
    }
    
}
