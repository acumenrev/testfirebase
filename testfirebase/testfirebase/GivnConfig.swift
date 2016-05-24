//
//  GivnConfig.swift
//  testfirebase
//
//  Created by Tri Vo on 5/19/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import UIKit
import ObjectMapper

class GivnConfig: Mappable {
    // vars
    var contest_expired:Int = 0
    var defaultTemplate:Int = 0
    var iosDefaultTemplate:Int = 0
    var postcardDonorMsg:String = ""
    var postcardImpactMsg:String = ""
    var postcardMarketing:String = ""
    
    init() {
        
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        contest_expired <- map["contest_expired"]
        defaultTemplate <- map["default_template"]
        iosDefaultTemplate <- map["ios_default_template"]
        postcardDonorMsg <- map["postcard_default_donor_message"]
        postcardImpactMsg <- map["postcard_impact_default_text"]
        postcardMarketing <- map["postcard_marketing_text"]
    }
}
