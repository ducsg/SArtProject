//
//  SignInVC.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

public class SignInVC: CustomTableViewController {
    
    @IBOutlet weak var tfEmail: CustomTextField!
    
    @IBOutlet weak var tfPwd: CustomTextField!
    
    @IBOutlet weak var btnSignIn: CustomButton!
    
    @IBOutlet weak var btnForgotPwd: CustomButton!
    private var email:String = ""
    private var pwd:String = ""
    public static var loginForCheckout = false
    
    override public func viewDidLoad() {
        self.btnForgotPwd.addUnderLine()
    }
    
    
    @IBAction func pressSignInButton(sender: AnyObject) {
        email = tfEmail.text!.trim()
        pwd = tfPwd.text!.trim().md5()
        if(validation()){
            let api:Api = Api()
            let parentView:UIView! = self.navigationController?.view
            api.initWaiting(parentView)
            let parameters = [APIKEY.EMAIL:email, APIKEY.PWD:pwd, APIKEY.IOS_REG_ID:MemoryStoreData().getString(MemoryStoreData.user_reg_id)]
            print(parameters)
            api.execute(ApiMethod.POST, url: ApiUrl.signin_url, parameters: parameters, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
                if(dataResult.success){
                    //store access token and account id
                    MemoryStoreData().setValue(APIKEY.ACCESS_TOKEN, value: dataResult.data[APIKEY.ACCESS_TOKEN].stringValue)
                    MemoryStoreData().setValue(APIKEY.ACCOUNT_ID, value: dataResult.data[APIKEY.ACCOUNT_ID].intValue)
                    //store data to stay login
                    MemoryStoreData().setValue(MemoryStoreData.user_email, value: self.email)
                    MemoryStoreData().setValue(MemoryStoreData.user_pwd, value: self.pwd)
                    MemoryStoreData().setValue(MemoryStoreData.user_stayed_login, value: true)
                    self.cancelTap(self)
                    self.loginSuccess()
                }else{
                   Util().showAlert(dataResult.message, parrent: self)
                }
            })
        }
    }
    
    func loginSuccess() -> Void{
        MemoryStoreData().setValue(MemoryStoreData.user_stayed_login, value: true)
        NSNotificationCenter.defaultCenter().postNotificationName(MESSAGES.NOTIFY.LOGIN_SUCCESS, object: nil)
        if(SignInVC.loginForCheckout){
            NSNotificationCenter.defaultCenter().postNotificationName(MESSAGES.NOTIFY.CHECKOUT_LOGIN, object: nil)
            SignInVC.loginForCheckout = false
        }
    }
    
    @IBAction func cancelTap(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func validation() -> Bool{
        if !(tfEmail.text!.characters.count > 0) {
            Util().showAlert(MESSAGES.COMMON.EMAIL_EMPTY, parrent: self)
            return false
        }
        
        if !(tfPwd.text!.characters.count > 0) {
            Util().showAlert(MESSAGES.REGISTER.PASS_EMPTY, parrent: self)
            return false
        }

        return true
    }
}
