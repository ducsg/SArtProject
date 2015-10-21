//
//  RegisterTB.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

public class RegisterTB: CustomTableViewController {
    
    @IBOutlet weak var tfEmail: CustomTextField!
    @IBOutlet weak var tfPwd: CustomTextField!
    @IBOutlet weak var tfRePwd: CustomTextField!
    @IBOutlet weak var btnRegister: CustomButton!
    
    private var email:String = ""
    private var pwd:String = ""
    private var rePwd:String = ""
    
    override public func viewDidLoad() {
        
    }
    
    @IBAction func pressRegisterButton(sender: AnyObject) {
        email = tfEmail.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        pwd = tfPwd.text!.trim().md5()
        rePwd = tfRePwd.text!.trim().md5()
        if(validation()){
            let api:Api = Api()
            let parentView:UIView! = self.navigationController?.view
            api.initWaiting(parentView)
            api.execute(ApiMethod.POST, url: ApiUrl.register_url, parameters: [APIKEY.EMAIL:email, APIKEY.PWD:pwd, APIKEY.REPWD:rePwd], resulf: {(dataResult: (success: Bool, message: String, data: AnyObject!)) -> Void in
                if(dataResult.success){
                    if let dat = dataResult.data as? NSMutableDictionary {
                        var tokenStr = ""
                        var idNumb = 0
                        
                        if let str = dat.objectForKey(APIKEY.ACCESS_TOKEN) as? String {
                            tokenStr = str
                        }
                        
                        if let numb = dat.objectForKey(APIKEY.ACCOUNT_ID) as? Int {
                            idNumb = numb
                            
                        }
                        let account:Account = Account()
                        account.setAcountInfo(accessTokenStr: tokenStr, accountID: idNumb)
                        DataManager.sharedInstance.user = account
                        self.loginSuccess()
                        self.cancelTap(self)
                        
                        //store data to stay login
                        MemoryStoreData().setValue(MemoryStoreData.user_email, value: self.email)
                        MemoryStoreData().setValue(MemoryStoreData.user_pwd, value: self.pwd)
                        MemoryStoreData().setValue(MemoryStoreData.user_stayed_login, value: true)
                    }
                }else{
                    Util().showAlert(dataResult.message, parrent: self)
                }
            })
        }else{
            
        }
    }
    
    
    func loginSuccess() -> Void{
        MemoryStoreData().setValue(MemoryStoreData.user_stayed_login, value: true)
        NSNotificationCenter.defaultCenter().postNotificationName(MESSAGES.NOTIFY.LOGIN_SUCCESS, object: nil)
    }
    
    @IBAction func cancelTap(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
 
    //validate data
    private func validation() -> Bool{
        var err:[String]
        
        if tfEmail.text!.isEmpty {
            Util().showAlert(MESSAGES.COMMON.EMAIL_EMPTY, parrent: self)
            return false
        }
        
        if !UtilOjbC.IsValidEmail(tfEmail.text)  {
            Util().showAlert(MESSAGES.COMMON.EMAIL_INVALID, parrent: self)
            return false
        }
        
        if tfPwd.text!.isEmpty {
            Util().showAlert(MESSAGES.REGISTER.PASS_EMPTY, parrent: self)
            return false
        }
        
        if !Util().IsValidPassword(tfPwd.text!) {
            Util().showAlert(MESSAGES.REGISTER.PASS_INVALID, parrent: self)
            return false
        }
        
        
        if tfRePwd.text!.isEmpty {
            Util().showAlert(MESSAGES.REGISTER.RE_PASS_EMPTY, parrent: self)
            return false
        }
        
        if tfRePwd.text !=  tfPwd.text{
            Util().showAlert(MESSAGES.REGISTER.COMPARE_PASSWORD, parrent: self)
            return false
        }
        
        return true
    }
}
