//
//  ChangePasswordTB.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/10/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChangePasswordTB: CustomTableViewController {
    
    @IBOutlet weak var tfOldPwd: CustomTextField!
    @IBOutlet weak var tfPwd: CustomTextField!
    @IBOutlet weak var tfRePwd: CustomTextField!
    
    private var old:String = ""
    private var pwd:String = ""
    private var rePwd:String = ""
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelTap(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveTap(sender: AnyObject) {
        old = tfOldPwd.text!.trim().md5()
        pwd = tfPwd.text!.trim().md5()
        rePwd = tfRePwd.text!.trim().md5()
        if(validation()){
            let parameters = [
                APIKEY.OLD_PWD:old,
                APIKEY.NEW_PWD:pwd,
                APIKEY.REPWD:rePwd
            ]
            print(parameters)
            let api:Api = Api()
            let parentView:UIView! = self.navigationController?.view
            api.initWaiting(parentView)
            api.execute(ApiMethod.POST, url: ApiUrl.change_pwd_url, parameters: parameters, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
                if(dataResult.success){
                    MemoryStoreData().setValue(MemoryStoreData.user_pwd, value: self.pwd)
                    self.cancelTap(self)
                }else{
                    Util().showAlert(dataResult.message, parrent: self)
                }
            })
        }
    }
    
    
    //validate data
    private func validation() -> Bool{
        if tfOldPwd.text!.isEmpty {
            Util().showAlert(MESSAGES.REGISTER.OLD_PASS_EMPTY, parrent: self)
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
