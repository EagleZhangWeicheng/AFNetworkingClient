//
//  SwiftAFNetworking.swift
//  AFNetworkingSwift
//
//  Created by eagle on 14/12/5.
//  Copyright (c) 2014年 eagle. All rights reserved.
//

//需要设置APPVesion的值


import UIKit
protocol EagleAFNetworkingDelegate:NSObjectProtocol {
    func willRequst(swiftAFNetworking:EagleAFNetworking)
    func requestDidfinished(swiftAFNetworking:EagleAFNetworking,withdata:AnyObject)
    func requiredDidFailed(swiftAFNetworking:EagleAFNetworking,error:NSError)
}

class EagleAFNetworking: NSObject{
    weak var delegate:EagleAFNetworkingDelegate?
    var relativeURLString:NSString!
    var currentPage:Int = 1 //当前页数
    var pageCount:Int = 0   //
    var pageSize:Int = 0      //
    var tag:Int? = 0
    var param:NSDictionary? //
    var userToken:String!
    
    var success:((jsonData:AnyObject?)->Void)?
    var fail:((error:NSError)->Void)?

    //获取page页的数据
    func loadDataWithPage(page:Int){
        self.setParametersForRequest()
        
        var tempUrlString:String!
        if relativeURLString.rangeOfString("?").location != NSNotFound {
            tempUrlString = String("\(relativeURLString)&page=\(page)")
        }
        else{
            tempUrlString = String("\(relativeURLString)?page=\(page)")
        }
        
        self.currentPage = page
        self.delegate?.willRequst(self)
        
        EagleNetClient.sharedInstance.GET(tempUrlString, parameters: self.param, progress: nil, success: { (dataTask:NSURLSessionDataTask, withdata:AnyObject?) -> Void in
                self.delegate?.requestDidfinished(self, withdata: withdata!)
                self.success?(jsonData:withdata)
            }) { (dataTask:NSURLSessionDataTask?, error:NSError) -> Void in
                self.delegate?.requiredDidFailed(self, error: error)
                self.fail?(error:error)
        }
    }
    
    //获取数据
    func loadData(){
        self.loadDataWithPage(self.currentPage)
    }
    
    //重载数据
    func reloadData(){
        self.loadDataWithPage(1)
    }
    
    //获取下一页的数据
    func loadNextPage(){
        self.currentPage += 1
        self.loadDataWithPage(self.currentPage)
    }
    //获取上一页的数据
    func loadPrePage(){
        self.currentPage -= 1
        if self.currentPage == 0 {
            return
        }
        self.loadDataWithPage(self.currentPage)
    }
    
    //提交数据
    func postData(){
        self.currentPage = 1
        self.postDataNextPageIndex(self.currentPage)
    }
    
    //MARK:加载下一个数据
    func postDataNextPage(){
        self.currentPage += 1
        self.postDataNextPageIndex(self.currentPage)
    }
    
    func postDataNextPageIndex(page:Int){
        self.setParametersForRequest()
        
        var tempUrlString:String!
        if relativeURLString.rangeOfString("?").location != NSNotFound {
            tempUrlString = String("\(relativeURLString)&page=\(page)")
        }
        else{
            tempUrlString = String("\(relativeURLString)?page=\(page)")
        }
        
        if page == 1{
            tempUrlString = relativeURLString as String
        }
        
        self.delegate?.willRequst(self)
        
        let selfDelegate :EagleAFNetworkingDelegate? = self.delegate
        let weakSelf = self 
        EagleNetClient.sharedInstance.POST(tempUrlString, parameters: self.param, progress: nil, success: { (dataTask:NSURLSessionDataTask, withdata:AnyObject?) -> Void in
            selfDelegate?.requestDidfinished(weakSelf, withdata: withdata!)
            self.success?(jsonData:withdata)
            }) { (dataTask:NSURLSessionDataTask?, error:NSError) -> Void in
                selfDelegate?.requiredDidFailed(weakSelf, error: error)
                self.fail?(error:error)
        }
    }
    
    func setParametersForRequest() {
        self.setToken() //设置token
        self.setDevice()  //设置版本号
        self.setVersion() //设备判断设备
    }
    
    //MARK:设置token
    func setToken(){
        if let token = NSUserDefaults.standardUserDefaults().objectForKey("UserToken") as? String{
            EagleNetClient.sharedInstance.requestSerializer.setValue(token, forHTTPHeaderField: "SECAuthorization")
        }
    }
    
    //MARK:设置版本号
    func setVersion(){
            EagleNetClient.sharedInstance.requestSerializer.setValue(APPVesion, forHTTPHeaderField: "AppVersion")
    }
    
    //MARK:设备判断设备
   func setDevice(){
        var deviceValue:String!
        if UIUserInterfaceIdiom.Pad == UIDevice.currentDevice().userInterfaceIdiom{
            deviceValue = "iPad"
        }
        else if UIUserInterfaceIdiom.Phone == UIDevice.currentDevice().userInterfaceIdiom{
            deviceValue = "iPhone"
        }
        else{
            deviceValue = "IOS"
        }
        EagleNetClient.sharedInstance.requestSerializer.setValue(deviceValue, forHTTPHeaderField: "HeadDevice")
    
    }

}

