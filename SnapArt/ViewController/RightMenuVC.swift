//
//  RightMenuVC.swift
//  FrameBridgeLike
//
//  Created by HD on 10/2/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

class RightMenuVC: AMSlideMenuLeftTableViewController  {
    
    private var loginFlag:Bool = false
    
    private let MENU_DID_LOGIN = ["Make Art","Notifcations","My Account","My Order",
        "How SnapArt Works","Like SnapArt on FB",
        "Like SnapArt on Instargram","Rate on the App Store",
        "About Us","FAQs","Emails","Term of Service"]
    
    private let MENU_WILL_LOGIN = ["Make Art","About Us","FAQs","Emails","Term of Service"]
    
    private let LOGIN_TITLE  = "Log In"
    private let LOGOUT_TITLE  = "Log Out"
    private let CREATE_ACCOUNT_TITLE  = "Create an Account"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: "MenuCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MenuCell")
        // For registering classes
        tableView.registerClass(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        self.automaticallyAdjustsScrollViewInsets = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginReceivedNotification:", name:MESSAGES.NOTIFY.LOGIN_SUCCESS, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loginFlag == true  ? 15 : 9
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.loginFlag == true ? menuAfterLogin(indexPath) : menuBeforeLogin(indexPath)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.loginFlag == true {
            selectMenuAfterLogin(indexPath)
        }else {
            selectMenuBeforeLogin(indexPath)
        }
    }
    
    // MARK: SETUP LOGIN MENU VIEW
    func setLoginFlag(flag: Bool) -> Void{
        self.loginFlag = flag
        self.tableView.reloadData()
    }
    func menuAfterLogin(indexPath: NSIndexPath) -> MenuCell  {
        let  cell = MenuCell.instanceFromNib()
        switch indexPath.row {
            
        case 0,1,2,3,4,5,5,6,7,8,9,10,11 :
            cell.setTextTitle(MENU_DID_LOGIN[indexPath.row])
            
        case 12:
            cell.addButton(LOGOUT_TITLE)
            cell.addButton(LOGOUT_TITLE).addTarget(self, action:"logoutTap:", forControlEvents: UIControlEvents.TouchUpInside)
        default:
            cell.hiddenTextField(true)
            print("default", terminator: "")
            
        }
        return cell
    }
    
    func menuBeforeLogin(indexPath: NSIndexPath) -> MenuCell  {
        let  cell = MenuCell.instanceFromNib()
        switch indexPath.row {
        case 0,1,2,3,4:
            cell.setTextTitle(MENU_WILL_LOGIN[indexPath.row])
        case 5:
            let btn = cell.addButton(LOGIN_TITLE)
            btn.addTarget(self, action: Selector("loginTap:"), forControlEvents: UIControlEvents.TouchUpInside)

        case 6:
            let btn = cell.addButton(CREATE_ACCOUNT_TITLE)
            btn.addTarget(self, action: Selector("registerTap:"), forControlEvents: UIControlEvents.TouchUpInside)
            
        default:
            cell.hiddenTextField(true)
        }
        return cell
    }
    
    func selectMenuAfterLogin(indexPath: NSIndexPath) -> Void  {
        switch indexPath.row {
        case 0:
            //Make Art
            print("case \(indexPath.row)", terminator: ""); break
        case 1:
            //Notifications
            print("case", terminator: ""); break
        case 2:
            //My account
            print("case", terminator: ""); break
        case 3:
            //My order
            print("case", terminator: ""); break
        case 4:
            // How SnapArt Works
            print("case", terminator: ""); break
        case 5:
            SocialNetwork.Facebook.openPage()
            // Like on facebook
            print("case", terminator: ""); break
        case 6:
            // Like on Instagram
            SocialNetwork.Instagram.openPage()
            print("case", terminator: ""); break
        case 7:
            // Rate on the App Store
            print("case", terminator: ""); break
        case 8:
            // About Us
            print("case", terminator: ""); break
        case 9:
            // FAQs
            print("case", terminator: ""); break
        case 10:
            // Emails
            print("case", terminator: ""); break
        case 11:
            // Term of service
            print("case", terminator: ""); break
        default:
            print("default", terminator: "")
        }
        
    }
    
    func selectMenuBeforeLogin(indexPath: NSIndexPath) -> Void  {
        switch indexPath.row {
        case 0:
            print("case", terminator: ""); break
        case 1:
            print("case", terminator: ""); break
        case 2:
            print("case", terminator: ""); break
        case 3:
            print("case", terminator: ""); break
        case 4:
            print("case", terminator: ""); break
        default:
            print("default", terminator: "")
        }
        
    }
   
    func loginReceivedNotification(sender:AnyObject) -> Void  {
        if MemoryStoreData().getBool(MemoryStoreData.user_stayed_login)  {
            self.loginFlag = true
            self.tableView.reloadData()
        }
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: MESSAGES.NOTIFY.LOGIN_SUCCESS, object: nil)
    }

    //MARK: REGISTER
    func registerTap(sender:AnyObject) -> Void  {
        let nv = Util().getControllerForStoryBoard("RegisterNC") as! CustomNavigationController
        self.mainVC!.closeLeftMenu()
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    //MARK: LOGIN TAP

    func loginTap(sender:AnyObject) -> Void  {
        let nv = Util().getControllerForStoryBoard("LoginNC") as! CustomNavigationController
        self.mainVC!.closeLeftMenu()
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    
    //MARK: LOGOUT TAP
    
    func logoutTap(sender:AnyObject) -> Void  {
        self.mainVC!.closeLeftMenu()
        Api().execute(.POST, url: ApiUrl.signout_url, parameters: NSDictionary() as! [String : String], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) in
            if(dataResult.success){
                self.loginFlag = false
                self.tableView.reloadData()
                MemoryStoreData().setValue(MemoryStoreData.user_stayed_login, value: false)
            }else{
                Util().showAlert(dataResult.message, parrent: self)
            }
        })
    }
 
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
