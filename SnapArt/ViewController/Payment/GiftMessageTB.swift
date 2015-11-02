//
//  GiftMessageVC.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/1/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class GiftMessageTB: CustomTableViewController, UITextViewDelegate {
    
    @IBOutlet weak var btnSave: CustomBarButtonItem!
    
    @IBOutlet weak var tvMessage: UITextView!
    
    var placeHolderText = "Placeholder Text..."
    
    override func viewDidLoad() {
        btnSave.enabled = false
        tvMessage.layer.borderColor = SA_STYPE.BORDER_TEXTFIELD_COLOR.CGColor
        tvMessage.layer.borderWidth = 1.0;
        tvMessage.delegate = self
        tvMessage.backgroundColor = UIColor.whiteColor()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool{
        if(self.tvMessage.text.characters.count > 1){
            self.btnSave.enabled = true
        }else{
            self.btnSave.enabled = false
        }
        return true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        self.tvMessage.textColor = UIColor.blackColor()
        
        if(self.tvMessage.text == placeHolderText) {
            self.tvMessage.text = ""
        }
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.text == "") {
            self.tvMessage.text = placeHolderText
            self.tvMessage.textColor = UIColor.lightGrayColor()
        }
    }
        
    @IBAction func pressbtnCancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
