//
//  GivnConfigModel.swift
//  testfirebase
//
//  Created by Tri Vo on 5/23/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import Foundation
import JSONModel

class GivnConfigModel: JSONModel {
    var contest_expired:Int = 0
    var default_template:Int = 0
    var ios_default_template:Int = 0
    var postcard_default_donor_message:String = ""
    var postcard_impact_default_text:String = ""
    var postcard_marketing_text:String = ""
    var test:String = ""
    
    override class func propertyIsOptional(propertyName: String!) -> Bool {
        return true
    }
}
