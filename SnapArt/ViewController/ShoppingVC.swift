//
//  ShoppingVC.swift
//  SnapArt
//
//  Created by HD on 10/26/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class ShoppingVC: CustomViewController , UIActionSheetDelegate {
    private var ADD_TO_CARD = "Add to card"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkOut() -> Void {
        let actionSheet = UIActionSheet(title: ADD_TO_CARD, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Braintree", "Card IO")
        actionSheet.showInView(self.view)
    }
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        switch buttonIndex{
        case 0:
            NSLog("Braintree");
            self.paymentUsingBraintree()
            break;
        case 1:
            NSLog("Card IO");
            self.paymentUsingCardIO()
            break;
        default:
            NSLog("Default");
            break;
            //Some code here..
        }
    }
    
    //MARK: Payment using Braintree
    func paymentUsingBraintree() -> Void {
        
    }
    
    //MARK: Payment using Card IO
    func paymentUsingCardIO() -> Void {
        
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
