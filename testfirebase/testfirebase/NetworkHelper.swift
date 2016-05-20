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


class NetworkHelper: NSObject {
    
    func getConfigFile() -> Void {
        let url:String = "https://posiba-mobile.s3.amazonaws.com/config-dev.json"
        
        Alamofire.request(.GET, url).responseObject { (res : Response<GivnConfig, NSError>) in
            let config:GivnConfig? = res.result.value;
            
//            DDLogDebug((config?.postcardDonorMsg)!)
//            DDLogWarn("GivnConfig: " + (config?.toJSONString())!)
            DDLogDebug("contest_expired: \(config!.contest_expired)")
        }
        
    }
    
    func loginGivn() -> Void {
        /*
         NSString *strEmail = @"han@gmail.com";
         NSString *strPwd = @"123456";
         
         NSString *emailPassword = [NSString stringWithFormat:@"%@:%@", strEmail, strPwd];
         NSString *pEncodedString = [NSString stringWithFormat:@"%@ %@", [TUtils getSocialTypeString:kSocialType_None],[emailPassword base64EncodedString]];
         */
        let strEmail : String = "han@gmail.com"
        let strPwd : String = "123456"
        
        let emailPassword = (strEmail) + ":" + (strPwd)
        
        let encodeString = "Basic " + emailPassword.toBase64()
        
        
        Alamofire.request(.POST, "", headers: ["Authorization":encodeString,
            "Content-Type":"application/json; charset=utf-8"]).responseJSON { response in
                switch response.result {
                case .Success(let responseData):
                    print("")
                case .Failure(let error):
                    print("")
                }
        }
    }
    
    static let sharedInstance = NetworkHelper()
    
    private override init() {
        
    }
}
