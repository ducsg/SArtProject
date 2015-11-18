//
//  MemoryStoreData.swift
//  SnapArt
//
//  Created by HD on 10/16/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation
public class MemoryStoreData{
    let preferences = NSUserDefaults.standardUserDefaults()
    
    //key for save data
    public static let user_email:String = "user_email"
    public static let user_pwd:String = "user_password"
    public static let user_stayed_login:String = "stayed_login"
    public static let user_reg_id:String = "ios_reg_id"
    public static let user_lat:String = "user_lat"
    public static let user_long:String = "user_long"
    public static let user_country_code:String = "user_country_code"
    public static let current_order_id:String = "current_order_id"
    
    init(){
    }
    
    public func setValue(key:String, value:AnyObject){
        preferences.setValue(value, forKey: key)
        preferences.synchronize()
    }
    
    public func getString(key:String) -> String{
        if preferences.objectForKey(key) == nil {
            return ""
        } else {
            return preferences.stringForKey(key)!
        }
    }
    
    public func getInt(key:String) -> Int{
        if preferences.objectForKey(key) == nil {
            return -1
        } else {
            return preferences.integerForKey(key)
        }
    }
    
    
    
    public func getFloat(key:String) -> Float{
        if preferences.objectForKey(key) == nil {
            return 0
        } else {
            return preferences.floatForKey(key)
        }
    }
    
    public func getDouble(key:String) -> Double{
        if preferences.objectForKey(key) == nil {
            return 0
        } else {
            return preferences.doubleForKey(key)
        }
    }
    
    public func getBool(key:String) -> Bool{
        if preferences.objectForKey(key) == nil {
            return false
        } else {
            return preferences.boolForKey(key)
        }
    }
    
}