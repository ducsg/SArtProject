//
//  RegisterTB.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

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
            api.execute(ApiMethod.POST, url: ApiUrl.register_url, parameters: [APIKEY.EMAIL:email, APIKEY.PWD:pwd, APIKEY.REPWD:rePwd, APIKEY.IOS_REG_ID:MemoryStoreData().getString(MemoryStoreData.user_reg_id)], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
                if(dataResult.success){
                    MemoryStoreData().setValue(APIKEY.ACCESS_TOKEN, value: dataResult.data[APIKEY.ACCESS_TOKEN].stringValue)
                    MemoryStoreData().setValue(APIKEY.ACCOUNT_ID, value: dataResult.data[APIKEY.ACCOUNT_ID].intValue)
                    self.loginSuccess()
                    
                    //store data to stay login
                    MemoryStoreData().setValue(MemoryStoreData.user_email, value: self.email)
                    MemoryStoreData().setValue(MemoryStoreData.user_pwd, value: self.pwd)
                    MemoryStoreData().setValue(MemoryStoreData.user_stayed_login, value: true)
                    
                    self.cancelTap(self)
                }else{
                    Util().showAlert(dataResult.message, parrent: self)
                }
            })
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
