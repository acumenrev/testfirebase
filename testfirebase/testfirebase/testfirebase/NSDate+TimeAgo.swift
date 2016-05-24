//
//  NSDate+TimeAgo.swift
//  testfirebase
//
//  Created by Tri Vo on 5/23/16.
//  Copyright © 2016 acumen. All rights reserved.
//

/*
 
        < 1 minute       	= "Just now"
        < 1 hour         	= "x minutes ago"
        Today            	= "x hours ago"
        Yesterday        	= "Yesterday at 1:28pm"
        < Last 7 days    	= "Friday at 1:48am"
        < Last 30 days   	= "March 30 at 1:14 pm"
        < 1 year         	= "September 15"
        Anything else    	= "September 9, 2011"
 
 */

import Foundation

let SECOND = 1
let MINUTE = (SECOND * 60)
let HOUR   = (MINUTE * 60)
let DAY    = (HOUR   * 24)
let WEEK   = (DAY    * 7)
let MONTH  = (DAY    * 31)
let YEAR   = (Double(DAY) * 365.24)

extension NSDate {
    
    /*
        Mysql Datetime Formatted As Time Ago
        Takes in a mysql datetime string and returns the Time Ago date format
     */
    static func mysqlDatetimeFormattedAsTimeAgo(mysqlDateTime : String) -> NSString {
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date : NSDate = dateFormatter.dateFromString(mysqlDateTime)!
        
        return date.formattedAsTimeAgo()
    }
    
    
    // MARK: Date Comparison Methods
    
    func isSameDayAs(comparisonDate : NSDate) -> Bool {
        let dateComparisonFormatter = NSDateFormatter()
        dateComparisonFormatter.dateFormat = "yyyy-MM-dd"
        
        return (dateComparisonFormatter.stringFromDate(self) == dateComparisonFormatter.stringFromDate(comparisonDate))
        
    }
    
    func dateBySubtractingDays(numDays : NSInteger) -> NSDate {
        let aTimeInterval = self.timeIntervalSinceReferenceDate + NSTimeInterval(DAY*(-numDays))
        return NSDate(timeIntervalSinceReferenceDate: aTimeInterval)
    }
    
    func isYesterday(now : NSDate) -> Bool {
        return self.isSameDayAs(now.dateBySubtractingDays(1))
    }
    
    func isLastWeek(secondsSince : NSTimeInterval) -> Bool {
        return secondsSince < NSTimeInterval(WEEK)
    }
    
    // MARK: Formatting method
    
    func formattedAsTimeAgo() -> NSString {
        // Now
        let now : NSDate = NSDate()
        let secondSince : NSTimeInterval = -(self.timeIntervalSinceDate(now))
        
        if secondSince < NSTimeInterval(MINUTE) {
            return "Just now"
        }
        
        if secondSince < NSTimeInterval(HOUR) {
            return self.formatMinutesAgo(secondSince)
        }
        
        if self.isSameDayAs(now) {
            return self.formatAsToday(secondSince)
        }
        
        if self.isYesterday(now) {
            return "yesterday"
        }
        
        return self.formatAsOther()
    }
    
    /**
     Format minute ago
     
     - parameter secondSince: Second since
     
     - returns: String value
     */
    func formatMinutesAgo(secondSince : NSTimeInterval) -> NSString {
        let minsSince : Int = Int(secondSince)/MINUTE
        
        if minsSince == 1 {
            return "1 minute ago"
        } else {
            return NSString(format: "%d minutes ago", minsSince)
        }
    }
    
    func formatAsToday(secondSince : NSTimeInterval) -> NSString {
        let minsSince : Int = Int(secondSince)/HOUR
        
        if minsSince == 1 {
            return "1 hour ago"
        } else {
            return NSString(format: "%d hours ago", minsSince)
        }
    }
    
    func formatAsYesterday() -> NSString {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "h:mm a"
        
        return NSString(format: "Yesterday at %@", dateFormatter.stringFromDate(self))
    }
    
    func formatAsLastWeek() -> NSString {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "EEEE 'at' h:mm a"
        
        return dateFormatter.stringFromDate(self)
    }
    
    func formatAsLastMonth() -> NSString {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MMMM d 'at' h:mm a"
        
        return dateFormatter.stringFromDate(self)
    }
    
    func formatAsLastYear() -> NSString {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.stringFromDate(self)
    }
    
    func formatAsOther() -> NSString {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.stringFromDate(self)
    }
}