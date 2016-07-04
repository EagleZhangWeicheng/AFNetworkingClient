//
//  BeansNetClient.swift
//  AFNetworkingSwift
//
//  Created by eagle on 14/12/5.
//  Copyright (c) 2014年 eagle. All rights reserved.
//

//需要设置BASE_URL


import UIKit

class EagleNetClient: AFHTTPSessionManager {
    class var sharedInstance : EagleNetClient {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : BeansNetClient? = nil
        }
        dispatch_once(&Static.onceToken) {
            let temp = BeansNetClient(baseURL: NSURL(string: BASE_URL))
            temp.responseSerializer.acceptableContentTypes = Set(arrayLiteral:"application/json", "text/json", "text/javascript","text/html")
            Static.instance = temp
        }
        return Static.instance!
    }
}
