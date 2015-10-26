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
}
