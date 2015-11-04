//
//  AppDelegate.swift
//  SnapArt
//
//  Created by HD on 10/6/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import FBAudienceNetwork
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON
import FBSDKShareKit
//import InstagramKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate   {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        switch(getMajorSystemVersion()) {
        case 7:
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(
                [UIRemoteNotificationType.Badge, UIRemoteNotificationType.Sound, UIRemoteNotificationType.Alert])
        case 8:
            if #available(iOS 8.0, *) {
                let pushSettings: UIUserNotificationSettings = UIUserNotificationSettings(
                    forTypes:
                    [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound],
                    categories: nil)
                UIApplication.sharedApplication().registerUserNotificationSettings(pushSettings)
                UIApplication.sharedApplication().registerForRemoteNotifications()
            } else {
                // Fallback on earlier versions
            }
        default: break 
        }
        
        if(MemoryStoreData().getBool(MemoryStoreData.user_stayed_login)){
            Api().execute(ApiMethod.POST, url: ApiUrl.signin_url, parameters: [APIKEY.EMAIL:MemoryStoreData().getString(MemoryStoreData.user_email), APIKEY.PWD:MemoryStoreData().getString(MemoryStoreData.user_pwd)], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
                if(dataResult.success){
                    MemoryStoreData().setValue(APIKEY.ACCESS_TOKEN, value: dataResult.data[APIKEY.ACCESS_TOKEN].stringValue)
                    MemoryStoreData().setValue(APIKEY.ACCOUNT_ID, value: dataResult.data[APIKEY.ACCOUNT_ID].intValue)
                    NSNotificationCenter.defaultCenter().postNotificationName(MESSAGES.NOTIFY.LOGIN_SUCCESS, object: nil)
                }else{
                    Util().showAlert(dataResult.message, parrent: self)
                }
            })
        }else{
            MemoryStoreData().setValue(APIKEY.ACCESS_TOKEN, value: "")
        }
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Override point for customization after application launch.
        //        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    //MARK: PUSH NOTIFICATION
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let trimEnds = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"))
        let cleanToken = trimEnds.stringByReplacingOccurrencesOfString(" ", withString: "", options: [])
    }
    
    // Failed to register for Push
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("Failed to get token; error: %@", error) //Log an error for debugging purposes, user doesn't need to know
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    
    }
    func getMajorSystemVersion() -> Int {
        return Int(String(Array(UIDevice.currentDevice().systemVersion.characters)[0]))!
    }
    
}

