//
//  TUtils.swift
//  testfirebase
//
//  Created by Tri Vo on 5/20/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import Foundation
import UIKit

class TUtils: NSObject {
    
    /**
     Email validation
     
     - parameter email: Email need to be validated
     
     - returns: True if email is valid
     */
    static func emailValidation(email : String) -> Bool {
        if email.isEmpty {
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z]+([._%+-]{1}[A-Z0-9a-z]+)*@[A-Z0-9a-z]+([.-]{1}[A-Z0-9a-z]+)*(\\.[A-Za-z]{2,4}){0,1}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluateWithObject(email)
    }
    /**
     Return app version
     
     - returns: String value
     */
    static func appVersion() -> String? {
        let appVersion : String? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as? String
        return appVersion
    }
    
    /**
     Get current milli second
     
     - returns: Time as String
     */
    static func currentMilliTime() -> String {
        let currentDate = NSDate()
        
        let timeInterval = currentDate.timeIntervalSince1970
        
        return String(timeInterval)
    }
    
    /**
     Normalize URL for requesting. Adding percentage symbol
     
     - parameter requestURL: URL
     
     - returns: Normalized URL
     */
    static func normalizeURLForRequest(requestURL : String) -> String {
        return requestURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
    
    /**
     Check whether text field contains only number or not
     
     - parameter stringValue: String value
     - parameter range:       range
     
     - returns: true if textfield contains only number
     */
    static func isTextFieldContainsOnlyNumber( stringValue : String, range : NSRange) -> Bool {
        let lengthOfString : Int = stringValue.characters.count
        var isDotExist : Bool = false
        
        
        for index in 0..<lengthOfString {
            let character : unichar = String(stringValue[stringValue.startIndex.advancedBy(index)]) as! unichar
            if character < 48 && character != 46 {
                return false
            }
            
            if character > 57 {
                return false
            }
            
            if character == 46 {
                // dot
                if isDotExist {
                    return false
                } else {
                    isDotExist = true
                }
            }
        }
        
        let prposedNewLength = stringValue.characters.count - range.length + stringValue.characters.count
        
        if prposedNewLength > 6 {
            return true
        }
        
        return true
    }
    
    /**
     Draw dashed border around view
     
     - parameter v:           View
     - parameter borderColor: Border color
     */
    static func drawDashBorderAroundView(v : UIView, borderColor : UIColor) -> Void {
        let cornerRadius : CGFloat = 2
        let borderWitdth : CGFloat = 2
        let dashPattern1 : NSInteger = 4
        let dashPattern2 : NSInteger = 4
        
        // drawing
        let frame : CGRect = v.bounds
        
        let shapeLayer = CAShapeLayer()
        
        // creating a path
        let path : CGMutablePath = CGPathCreateMutable()
        
        // drawing a border around a view
        CGPathMoveToPoint(path, nil, 0, frame.size.height - cornerRadius)
        CGPathAddLineToPoint(path, nil, 0, cornerRadius)
        CGPathAddArc(path, nil, cornerRadius, cornerRadius, cornerRadius, CGFloat(M_PI), CGFloat(-M_PI_2), false)
        CGPathAddLineToPoint(path, nil, frame.size.width, frame.size.height - cornerRadius);
        CGPathAddArc(path, nil, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, 0, CGFloat(M_PI_2), false);
        CGPathAddLineToPoint(path, nil, cornerRadius, frame.size.height);
        CGPathAddArc(path, nil, cornerRadius, frame.size.height - cornerRadius, cornerRadius, CGFloat(M_PI_2), CGFloat(M_PI), false);
        
        //path is set as the _shapeLayer object's path
        shapeLayer.path = path
        // release path CGPathRelease(path);
        
        shapeLayer.backgroundColor = UIColor.clearColor().CGColor
        shapeLayer.frame = frame
        shapeLayer.masksToBounds = false;
        shapeLayer.setValue(NSNumber.init(bool: false), forKey: "isCircle")
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = borderColor.CGColor
        shapeLayer.lineWidth = borderWitdth
        shapeLayer.lineDashPattern = [NSNumber.init(integer: dashPattern1), NSNumber.init(integer: dashPattern2)]
        shapeLayer.lineCap = kCALineCapRound
        v.layer.addSublayer(shapeLayer)
        v.layer.cornerRadius = cornerRadius
    }
    
    /**
     Get current OS of device
     
     - returns: Current OS
     */
    static func currentOSVersion() -> Float {
        return Float(UIDevice.currentDevice().systemVersion)!
    }
    
    /**
     Remove leading and trailing spaces in a string
     
     - parameter stringValue: String
     
     - returns: Result string
     */
    static func removeLeadingAndTrailingSpaceInString(stringValue : String) -> String {
        let result : String = stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        return result
    }
    
    /**
     Remove white spaces in string
     
     - parameter stringVal: String
     
     - returns: Modified string
     */
    static func removeWhiteSpacesInString(stringVal : String) -> String {
        return stringVal.stringByReplacingOccurrencesOfString(" ", withString: "")
    }
    
    /**
     Capture view as a image
     
     - parameter view: View
     
     - returns: UIImage object
     */
    static func imageWithView(view : UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let img : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
    
    /**
     Cropping image
     
     - parameter img:  Image need to be cropped
     - parameter rect: Size for cropping
     
     - returns: Cropped image
     */
    static func croppingImage(img : UIImage, rect : CGRect) -> UIImage {
        let imageRef : CGImageRef = CGImageCreateWithImageInRect(img.CGImage, rect)!
        
        let croppedImg : UIImage = UIImage(CGImage: imageRef)
        
        return croppedImg
    }
    
    /**
     Capture UIView as UIImage
     
     - parameter view: View
     
     - returns: Image
     */
    static func captureView(view : UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let img : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
    
    /**
     Open URL
     
     - parameter url: URL
     */
    static func openURL(url : String) -> Void {
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    /**
     Round button at corners
     
     - parameter button:  Button
     - parameter corners: Corners
     */
    static func roundButton(button : UIButton, corners : UIRectCorner) -> Void {
        let maskPath : UIBezierPath = UIBezierPath(roundedRect: button.bounds, byRoundingCorners: corners, cornerRadii: CGSizeMake(20.0, 30.0))
        let maskLayer : CAShapeLayer = CAShapeLayer()
        maskLayer.frame = button.bounds
        maskLayer.path = maskPath.CGPath
        button.layer.mask = maskLayer
    }
    
    static func writeImageToDisk(img : UIImage, fileName : String) -> Void {
        /*
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
         
         // Save image.
         [UIImagePNGRepresentation(img) writeToFile:filePath atomically:YES];
         */
        let documentDirectoryURL =  try! NSFileManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        
        
    }
    
    /**
     Add shadow on bottom of a view
     
     - parameter view: View
     */
    static func addShadowOnBottomOfView(view : UIView) -> Void {
        view.layer.shadowColor = (UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)).CGColor
        view.layer.shadowOffset = CGSizeMake(0, 1.0)
        view.layer.shadowOpacity = 1.0;
        view.layer.shadowRadius = 0.0;
        view.layer.masksToBounds = false;
        view.layer.cornerRadius = 4.0;
    }
    
    /**
     Remove shadow on bottom of a view
     
     - parameter view: View
     */
    static func removeShadowOnBottomOfView(view : UIView) -> Void {
        view.layer.shadowColor = (UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)).CGColor
        view.layer.shadowOffset = CGSizeMake(0, 1.0)
        view.layer.shadowOpacity = 1.0;
        view.layer.shadowRadius = 0.0;
        view.layer.masksToBounds = false;
        view.layer.cornerRadius = 4.0;
    }
    
    /**
     Link validation
     
     - parameter url: URL
     
     - returns: true if valid link
     */
    static func validateLink(url : String) -> Bool {
        let len  = url.characters.count
        
        if len == 0 || len > 200 {
            return false
        }
        
        var url = TUtils.removeLeadingAndTrailingSpaceInString(url)
        
        url = url.lowercaseString

        let exp : NSRegularExpression = try! NSRegularExpression(pattern: "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z]{2,6})([\\.|/]?((\\w)*|([0-9]*)|([-|_])*)+)+(/)?(\\?.*)?", options: .CaseInsensitive)
        
        let range : NSRange = exp.rangeOfFirstMatchInString(url, options: .ReportCompletion, range: NSMakeRange(0, url.characters.count))
        
        if NSEqualRanges(range, NSMakeRange(NSNotFound, 0)) == false {
            return true
        }
        return false
    }
    
    /**
     Get identifier for vender
     
     - returns: UDID
     */
    static func getIdentifierForVender() -> String {
        var udid : String = ""
        
        #if TARGET_IPHONE_SIMULATOR
            // iPhone simulator ID will be changed everytime
        #else
            udid = (UIDevice.currentDevice().identifierForVendor?.UUIDString)!
        #endif
    
        
        let returnStr = udid.stringByReplacingOccurrencesOfString("-", withString: "")
        
        return returnStr
    }
    
    
    static func writeJSONToFile(json : NSDictionary, fileName : String) -> Bool {
        let documentDirectoryURL =  try! NSFileManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        
        
        return true
    }
    
    
}
