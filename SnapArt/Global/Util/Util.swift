//
//  Util.swift
//  SnapArt
//
//  Created by HD on 10/13/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import Foundation
public class Util: NSObject {
    
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    
    func getControllerForStoryBoard(indertifer:String) -> AnyObject? {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: AnyObject? = storyboard.instantiateViewControllerWithIdentifier(indertifer)
        return controller
    }
    
    func showAlert(message:String,parrent:AnyObject!) -> Void {
        let alert:UIAlertView = UIAlertView(title: MESSAGES.SA_ALERT_TIL, message: message, delegate: parrent, cancelButtonTitle: "Ok")
        alert.show()
        
    }
    
    func IsValidPassword(password:String) -> Bool{
        if(password.characters.count < 6){
            return false
        }else{
            return true
        }
    }
    
    func imageResize(imageObj:UIImage, sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // !!!
        return scaledImage
    }
    
    //get width device
    func getScreenWidth() -> Float{
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        return Float(width)
    }
    
    //get height device
    func getScreenHeight() -> Float{
        let bounds = UIScreen.mainScreen().bounds
        let height = bounds.size.height
        return Float(height)
    }
    
    func getViewWidth(view:UIView) -> Float{
        return Float(view.frame.size.width)
    }
    
    func getCountryCode() -> String{
        return NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
    }
}
