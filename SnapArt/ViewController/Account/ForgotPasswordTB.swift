//
//  ForgotPasswordTB.swift
//  SnapArt
//
//  Created by Khanh Duong on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

public class ForgotPasswordTB: CustomTableViewController{
    
    @IBOutlet weak var tfEmail: CustomTextField!
    
    @IBOutlet weak var lbGuide: CustomLabel!
    
    @IBOutlet weak var btnSend: CustomButton!
    
    private var email:String = ""
    
    override public func viewDidLoad() {
        
    }
    
    @IBAction func pressSendButton(sender: AnyObject) {
        email = tfEmail.text!.trim()
        if(validation()){
            let api:Api = Api()
            let parentView:UIView! = self.navigationController?.view
            api.initWaiting(parentView)
            api.execute(ApiMethod.POST, url: ApiUrl.forgot_url, parameters: [APIKEY.EMAIL:email], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
                if(dataResult.success){
                    DataManager.sharedInstance.user.forgotEmail = self.email
                    let nv = Util().getControllerForStoryBoard("ResetPasswordTB") as! ResetPasswordTB
                    self.navigationController?.pushViewController(nv, animated: true)
                }else{
                    Util().showAlert(dataResult.message, parrent: self)
                }
            })
        }
    }
    
    @IBAction func pressCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
  
    
    func validation() -> Bool{
        if !(tfEmail.text!.characters.count > 0) {
            Util().showAlert(MESSAGES.COMMON.EMAIL_EMPTY, parrent: self)
            return false
        }
        return true
    }
}
