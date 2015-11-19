//
//  McUtils.swift
//  mcwa
//
//  Created by 陈强 on 15/10/13.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import Foundation
import SwiftyJSON

let UMAppKey = "564da192e0f55afd93000e9d"

let URL_APPSTORE = "http://www.mckuai.com"
let URL_MC = "http://api.mckuai.com/interface.do?"
let URL_DETAILS = "http://api.mckuai.com/compose/"

//PageInfo 用于下拉刷新
class PageInfo {
    var currentPage: Int = 0
    var pageCount: Int = 0
    var pageSize: Int = 0
    var allCount: Int = 0
    
    init(currentPage: Int, pageCount: Int, pageSize: Int, allCount: Int) {
        self.currentPage = currentPage
        self.pageCount = pageCount
        self.pageSize = pageSize
        self.allCount = allCount
    }
    
    init(j: JSON) {
        self.currentPage = j["page"].intValue
        self.pageCount = j["pageCount"].intValue
        self.pageSize = j["pageSize"].intValue
        self.allCount = j["allCount"].intValue
    }
}

class MCUtils {
    //
}


