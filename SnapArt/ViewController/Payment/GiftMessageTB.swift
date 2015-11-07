//
//  GiftMessageVC.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/1/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

class GiftMessageTB: CustomTableViewController, UITextViewDelegate {
    
    @IBOutlet weak var tvMessage: UITextView!
    
    private var messageId = 0
    private var message = ""
    
    
    var placeHolderText = "Fill in this field if you would like to send a note along with your gift and we will hand write one for you. If you'd like to skip the note you can just leave this field blank."
    let tvMessageHolderColor = UIColor().fromHexColor("#999999")
    
    override func viewDidLoad() {
        tvMessage.layer.borderColor = SA_STYPE.BORDER_TEXTFIELD_COLOR.CGColor
        tvMessage.layer.borderWidth = 1.0;
        tvMessage.delegate = self
        
        if (tvMessage.text == "") {
            textViewDidEndEditing(tvMessage)
        }
        let tapDismiss = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapDismiss)
        
//        getMessage()
    }
    override func viewWillAppear(animated: Bool) {
        getMessage()
    }
    func getMessage(){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
                api.initWaiting(parentView)
        api.execute(.GET, url: ApiUrl.get_message_url, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                self.messageId = (dataResult.data["id"].number?.integerValue)!
                self.message = dataResult.data["content"].stringValue
                if(self.message.characters.count != 0){
                    self.tvMessage.text = dataResult.data["content"].stringValue
                    self.tvMessage.textColor = UIColor.blackColor()
                }
            }else{
                Util().showAlert(dataResult.message, parrent: self)
            }
        })
    }
    
    func saveMessage(){
        var param = [String : AnyObject]()
        if(messageId==0){
            param = ["content" : self.tvMessage.text]
        }else{
            param = ["id" : messageId, "content" : self.tvMessage.text]
        }
        let api = Api()
        //            let parentView:UIView! = self.navigationController?.view
        //            api.initWaiting(parentView)
        api.execute(.POST, url: ApiUrl.save_message_url, parameters: param, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                self.messageId = (dataResult.data.number?.integerValue)!
                self.message = self.tvMessage.text
                self.pressbtnCancel("")
            }else{
                Util().showAlert(dataResult.message, parrent: self)
            }
        })
    }
    
    func dismissKeyboard(){
        tvMessage.resignFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if (textView.text == "") {
            textView.text = placeHolderText
            textView.textColor = tvMessageHolderColor
        }
        textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView){
        if (textView.text == placeHolderText){
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
        textView.becomeFirstResponder()
    }
    
    @IBAction func pressbtnCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func pressBtnApply(sender: AnyObject) {
        saveMessage()
    }
    
    
}
