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
    
    func showAlert(message:String,parrent:AnyObject!) -> UIAlertView {
        let alert:UIAlertView = UIAlertView(title: MESSAGES.SA_ALERT_TIL, message: message, delegate: parrent, cancelButtonTitle: "OK")
        alert.show()
        return alert
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
    
    //check require field
    func checkRequireField(listFieldRequire: [CustomTextField]) -> Bool{
        var valid = true
        for i in 0...listFieldRequire.count-1{
            if(listFieldRequire[i].text?.characters.count == 0){
                listFieldRequire[i].applyErrorStyle()
                valid = false
            }else{
                listFieldRequire[i].setStyleForLabel()
            }
        }
        return valid
    }
         
    //get country list
    func getCountryList() -> [String]{
        var countries: [String] = []
        
        for code in NSLocale.ISOCountryCodes() as [String] {
            let id = NSLocale.localeIdentifierFromComponents([NSLocaleCountryCode: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayNameForKey(NSLocaleIdentifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        return countries
    }
    
    //format datetime
    func formatDatetime(strDate:String = "", inputFormat:String = "yyyy-MM-dd HH:mm:ss", outputFormat:String = "")-> String{
        let strTime: String? = strDate //"29/10/2015 20:00:00 +0000"
        let formatter = NSDateFormatter()
        formatter.dateFormat = inputFormat //"dd/mm/yyyy HH:mm:ss Z"
        let getDate:NSDate = formatter.dateFromString(strTime!)!
        
        
        let formatterOut = NSDateFormatter()
        formatterOut.dateFormat = outputFormat //"MM/dd/yy HH:mm a"
        return formatterOut.stringFromDate(getDate)
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}
