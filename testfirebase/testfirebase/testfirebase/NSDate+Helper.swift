//
//  NSDate+Helper.swift
//  testfirebase
//
//  Created by Tri Vo on 5/23/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import Foundation

extension NSDate {
    
    @nonobjc static let kNSDateHelperFormatFullDateWithTime    = "MMM d, yyyy h:mm a";
    @nonobjc static let kNSDateHelperFormatFullDate            = "MMM d, yyyy";
    @nonobjc static let kNSDateHelperFormatShortDateWithTime   = "MMM d h:mm a";
    @nonobjc static let kNSDateHelperFormatShortDate           = "MMM d";
    @nonobjc static let kNSDateHelperFormatWeekday             = "EEEE";
    @nonobjc static let kNSDateHelperFormatWeekdayWithTime     = "EEEE h:mm a";
    @nonobjc static let kNSDateHelperFormatTime                = "h:mm a";
    @nonobjc static let kNSDateHelperFormatTimeWithPrefix      = "'at' h:mm a";
    @nonobjc static let kNSDateHelperFormatSQLDate             = "yyyy-MM-dd";
    @nonobjc static let kNSDateHelperFormatSQLTime             = "HH:mm:ss";
    @nonobjc static let kNSDateHelperFormatSQLDateWithTime     = "yyyy-MM-dd HH:mm:ss";
    
    @nonobjc static var _calendar : NSCalendar = NSCalendar.currentCalendar()
    @nonobjc static var _displayFormatter : NSDateFormatter = NSDateFormatter()

    static func sharedCalendar() -> NSCalendar {
        _calendar.timeZone = NSTimeZone(name: "UTC")!
        return _calendar
    }
    
    static func sharedDateFormatter() -> NSDateFormatter {
        return _displayFormatter
    }
    
    
    func daysAgo() -> Int {
        let calendar = self.classForCoder.sharedCalendar()
        
        let components = calendar.components(.NSDayCalendarUnit, fromDate: self, toDate: NSDate(), options: .WrapComponents)
        
        return components.day
    }
    
    
}