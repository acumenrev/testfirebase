//
//  NetworkProtocol.swift
//  testfirebase
//
//  Created by Tri Vo on 5/24/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import Foundation

@objc public protocol NetworkProtocol : NSObjectProtocol {
    
    
    func getConfigFileSuccess() -> Void
    /**
     Get config failed
     
     
     */
    optional func getConfigFailed() -> Void
}

