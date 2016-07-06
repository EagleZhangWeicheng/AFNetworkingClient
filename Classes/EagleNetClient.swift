//
//  BeansNetClient.swift
//  AFNetworkingSwift
//
//  Created by eagle on 14/12/5.
//  Copyright (c) 2014年 eagle. All rights reserved.
//

import AFNetworking

//需要设置BASE_URL
class EagleNetClientConfig :NSObject{
    static var base_url:String!
    static var appVersion:String!
}

import UIKit

class EagleNetClient: AFHTTPSessionManager {
    class var sharedInstance : EagleNetClient {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : EagleNetClient? = nil
        }
        dispatch_once(&Static.onceToken) {
            let temp = EagleNetClient(baseURL: NSURL(string: EagleNetClientConfig.base_url))
            temp.responseSerializer.acceptableContentTypes = Set(arrayLiteral:"application/json", "text/json", "text/javascript","text/html")
            Static.instance = temp
        }
        return Static.instance!
    }
}
