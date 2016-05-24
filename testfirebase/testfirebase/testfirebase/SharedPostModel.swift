//
//  SharedPostModel.swift
//  testfirebase
//
//  Created by Tri Vo on 5/23/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import Foundation
import JSONModel

class SharedPostModel: JSONModel {

    var socials : NSArray?
    var createdDate : CLongLong?
    var donationDate : CLongLong?
    var donationId : Int?
    var influence : Int?
    var orgName : NSString?
    var orgUrl : NSString?
    var postId : Int?
    var shareImage : NSString?
    var orgId : Int?
    var type : NSString?
    var hasImage:Bool?
    var templateShared:Int?
    var badgesShared:NSArray?
    var timeShared:Float?
    var influenceShared:Int?
    var moneyShared:Double?
    var impact:NSString?
    var impactText:NSString?
    var message:NSString?
    var donationUrl:NSString?
    var impactMessage:NSString?
    var donorMessage:NSString?
    var campaignId:Int?
    
    override class func propertyIsOptional(propertyName: String!) -> Bool {
        return true
    }
    
}
