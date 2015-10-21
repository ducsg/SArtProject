//
//  ResetPasswordTB.swift
//  SnapArt
//
//  Created by Khanh Duong on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

public class ResetPasswordTB: CustomTableViewController {
    
    @IBOutlet weak var tfCode: CustomTextField!
    @IBOutlet weak var tfPwd: CustomTextField!
    @IBOutlet weak var tfRePwd: CustomTextField!
    @IBOutlet weak var btnUpdate: CustomButton!
    
    private var code:String = ""
    private var pwd:String = ""
    private var rePwd:String = ""
    
    override public func viewDidLoad() {
        
    }
    
    
    @IBAction func pressUpdateButton(sender: AnyObject) {
        code = tfCode.text!.trim()
        pwd = tfPwd.text!.trim().md5()
        rePwd = tfRePwd.text!.trim().md5()
        if(validation()){
            var api:Api = Api()
            let parentView:UIView! = self.navigationController?.view
            api.initWaiting(parentView)
            api.execute(ApiMethod.POST, url: ApiUrl.reset_pwd_url, parameters: [APIKEY.EMAIL:DataManager.sharedInstance.user.forgotEmail, APIKEY.CODE:code, APIKEY.PWD:pwd, APIKEY.REPWD:rePwd], resulf: {(dataResult: (success: Bool, message: String, data: AnyObject!)) -> Void in
                if(dataResult.success){
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                }else{
                    Util().showAlert(dataResult.message, parrent: self)
                }
            })
        }else{
            
        }
    }
    
    //validate data
    private func validation() -> Bool{
        var err:[String]
        if tfCode.text!.isEmpty {
            Util().showAlert(MESSAGES.REGISTER.VERIFICATION_EMPTY, parrent: self)
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
            Util().showAlert(MESSAGES.REGISTER.NEW_PASSWORD_EMPTY, parrent: self)
            return false
        }
        
        if tfRePwd.text !=  tfPwd.text{
            Util().showAlert(MESSAGES.REGISTER.COMPARE_FORGOT_PASSWORD, parrent: self)
            return false
        }
        return true
    }
    
    @IBAction func pressCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

