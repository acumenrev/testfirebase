//
//  StringExtension.swift
//  testfirebase
//
//  Created by Tri Vo on 5/20/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import Foundation

extension String
{
    func fromBase64() -> String {
        let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions(rawValue: 0))
        return String(data: data!, encoding: NSUTF8StringEncoding)!
    }
    
    func toBase64() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
}
