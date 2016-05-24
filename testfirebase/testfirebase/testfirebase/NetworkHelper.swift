//
//  NetworkHelper.swift
//  testfirebase
//
//  Created by Tri Vo on 5/19/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper
import CocoaLumberjack
import ObjectMapper



class NetworkHelper: NSObject {
    
    private static var appToken : String = ""
    static var donorId : Int = 0
    internal var networkDelegate : NetworkProtocol? = nil
    
    
    
    
    func getConfigFile() -> Void {
        let url:String = "https://posiba-mobile.s3.amazonaws.com/config-dev.json"
        
        Alamofire.request(.GET, url).responseObject { (res : Response<GivnConfig, NSError>) in
            let config:GivnConfig? = res.result.value;
            
//            DDLogDebug((config?.postcardDonorMsg)!)
//            DDLogWarn("GivnConfig: " + (config?.toJSONString())!)
            DDLogDebug("contest_expired: \(config!.contest_expired)")
        }
        
        
        Alamofire.request(.GET, url).responseJSON { res in
            switch res.result {
            case .Success(let responseData):
                let jsonData = responseData as! NSDictionary
                let givnConfig = try! GivnConfigModel(dictionary: jsonData as [NSObject : AnyObject])
                if self.networkDelegate != nil {
                    if ((self.networkDelegate?.respondsToSelector(#selector(NetworkProtocol.getConfigFileSuccess))) != nil) {
                        self.networkDelegate?.getConfigFileSuccess()
                    }
                }
                
                print()
            case .Failure(let error):
                if self.networkDelegate != nil {
                    if ((self.networkDelegate?.respondsToSelector(#selector(NetworkProtocol.getConfigFailed)))) != nil {
                        self.networkDelegate?.getConfigFailed!()
                    }
                }
                print()
            }
        }
    }
    
    func loginGivn() -> Void {
    
        let strEmail : String = "han@gmail.com"
        let strPwd : String = "123456"
        
        let emailPassword = (strEmail) + ":" + (strPwd)
        
        let encodeString = "Basic " + emailPassword.toBase64()
        
        
        Alamofire.request(.POST, "https://api-dev.givn.social/v1/donors/auth", headers: ["Authorization":encodeString,
            "Content-Type":"application/json; charset=utf-8"]).responseJSON { response in
                switch response.result {
                case .Success(let responseData):
                    let jsonData = responseData as! NSDictionary
                    
                    let donorId : NSNumber = jsonData["donorId"] as! NSNumber
                    
                    NetworkHelper.donorId = donorId.integerValue
                    NetworkHelper.appToken = jsonData["token"] as! String
                    DDLogDebug(jsonData.descriptionInStringsFileFormat)
                case .Failure(let error):
                    print("")
                }
        }
    }
    
    func getSharedPosts(offset : UInt) -> Void {
        
        let strURL : NSString = NSString(format: "https://api-dev.givn.social/v1/donors/socials/posts?limit=25&offset=%d", offset)
        
        Alamofire.request(.GET, strURL as String, headers: ["Auth-Token" : NetworkHelper.appToken]).responseJSON { res in
            switch res.result {
            case .Success(let responseData):
                let jsonData = responseData as! NSDictionary
                DDLogDebug(jsonData.descriptionInStringsFileFormat)
                let listData = jsonData["data"] as! NSArray
                for index in 0..<listData.count {
                    
                    print()
                }
                print()
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    static let sharedInstance = NetworkHelper()
    
    private override init() {
        
    }
}
