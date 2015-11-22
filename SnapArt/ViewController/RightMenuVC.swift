//
//  RightMenuVC.swift
//  FrameBridgeLike
//
//  Created by HD on 10/2/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON
import MessageUI

class RightMenuVC: AMSlideMenuLeftTableViewController, MFMailComposeViewControllerDelegate  {
    
    private var loginFlag:Bool = false
    
    //    private let MENU_DID_LOGIN = ["Make Art","Notifcations","My Account","My Order",
    //        "How SnapArt Works","Like SnapArt on FB",
    //        "Like SnapArt on Instargram","Rate on the App Store",
    //        "About Us","FAQs"," Email Us ","Term of Service"]
    
    private let MENU_DID_LOGIN = ["Make Art","Notifcations","My Account","My Order", "Promotions", "About Us","FAQs","Email Us"]
    private let MENU_WILL_LOGIN = ["Make Art","About Us","FAQs","Email Us"]
    private let LOGIN_TITLE  = "Log In"
    private let LOGOUT_TITLE  = "Log Out"
    private let CREATE_ACCOUNT_TITLE  = "Create an Account"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: "MenuCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MenuCell")
        // For registering classes
        tableView.registerClass(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        self.tableView.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        self.tableView.separatorColor = UIColor.clearColor()
        self.automaticallyAdjustsScrollViewInsets = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginReceivedNotification:", name:MESSAGES.NOTIFY.LOGIN_SUCCESS, object: nil)
        
        if(MemoryStoreData().getString(APIKEY.ACCESS_TOKEN) != ""){
            self.loginFlag = true
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loginFlag == true  ? 9 : 8
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.loginFlag == true ? heightCellMenuAfterLogin(indexPath) : heightCellMenuBeforeLogin(indexPath)
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        return headView
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return self.loginFlag == true ? menuAfterLogin(indexPath) : menuBeforeLogin(indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.mainVC!.closeLeftMenu()
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
            
        case 0,1,2,3,4,5,5,6,7 :
            cell.setTextTitle(MENU_DID_LOGIN[indexPath.row])
            
        case 8:
            cell.addButton(LOGOUT_TITLE)
            cell.addButton(LOGOUT_TITLE).addTarget(self, action:"logoutTap:", forControlEvents: UIControlEvents.TouchUpInside)
        default:
            cell.hiddenTextField(true)
            print("default", terminator: "")
            
        }
        return cell
    }
    func heightCellMenuAfterLogin(indexPath: NSIndexPath) -> CGFloat  {
        switch indexPath.row {
        case 0,1,2,3,4,5,5,6,7 :
            return 44
        case 8:
            return 64
        default:
            return 44

        }
    }
    func heightCellMenuBeforeLogin(indexPath: NSIndexPath) -> CGFloat  {
        switch indexPath.row {
        case 0,1,2,3:
            return 44
        case 4:
            return 64
        case 5:
            return 64
        default:
            return 44
        }
    }
    
    func menuBeforeLogin(indexPath: NSIndexPath) -> MenuCell  {
        let  cell = MenuCell.instanceFromNib()
        switch indexPath.row {
        case 0,1,2,3:
            cell.setTextTitle(MENU_WILL_LOGIN[indexPath.row])
        case 4:
            let btn = cell.addButton(LOGIN_TITLE)
            btn.addTarget(self, action: Selector("loginTap:"), forControlEvents: UIControlEvents.TouchUpInside)
            
        case 5:
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
            gotoMakeArt()
            print("case \(indexPath.row)", terminator: ""); break
        case 1:
            //Notifications
            gotoNotifications()
            print("case", terminator: ""); break
        case 2:
            //My account MyAccount
            gotoMyAccount()
            print("case", terminator: ""); break
        case 3:
            //My order
            gotoMyOrder()
            print("case", terminator: ""); break
        case 4:
            //Promotion
            gotoPromotion()
            print("case", terminator: ""); break
        case 5:
            // About Us
            presentAboutlUs()
            print("case", terminator: ""); break
        case 6:
            // FAQs
            gotoFAQs()
            print("case", terminator: ""); break
        case 7:
            // Emails
            sendEmailUs()
            print("case", terminator: ""); break
        default:
            print("default", terminator: "")
        }
        
    }
    
    func selectMenuBeforeLogin(indexPath: NSIndexPath) -> Void  {
        switch indexPath.row {
        case 0:
            gotoMakeArt()
            print("case", terminator: ""); break
        case 1:
            //AboutlUs
            presentAboutlUs()
            print("case", terminator: ""); break
        case 2:
            // FAQs
            gotoFAQs()
            print("case", terminator: ""); break
        case 3:
            //Emails
            sendEmailUs()
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
                MemoryStoreData().setValue(APIKEY.ACCESS_TOKEN, value: "")
            }else{
                Util().showAlert(dataResult.message, parrent: self)
            }
        })
    }
    
    func gotoFAQs(){
        WebviewDetailsVC.title = "FAQs"
        WebviewDetailsVC.url = ApiUrl.faq_url
        let nv = Util().getControllerForStoryBoard("WebviewDetailsNC") as! CustomNavigationController
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    
    func gotoMakeArt(){
        let nv = Util().getControllerForStoryBoard("UploadViewVC") as! CustomNavigationController
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    
    func gotoNotifications(){
        let nv = Util().getControllerForStoryBoard("NotificationNC") as! CustomNavigationController
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    
    func gotoPromotion(){
        let nv = Util().getControllerForStoryBoard("PromotionInfoNC") as! CustomNavigationController
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    
    func gotoMyAccount(){
        let nv = Util().getControllerForStoryBoard("MyAccount") as! CustomNavigationController
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    func gotoMyOrder() {
        let nv = Util().getControllerForStoryBoard("MyOrderNC") as! CustomNavigationController
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    //send email func
    func sendEmailUs() -> Void {
        let url = NSURL(string: "mailto:hello@getsnapart.com")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func presentAboutlUs() -> Void {
        let vc:UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutUsNC") as! UINavigationController
        self.presentViewController(vc, animated: true, completion: nil)
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
