//
//  ViewController.swift
//  BraintreeDemo
//
//  Created by Khanh Duong on 10/19/15.
//  Copyright © 2015 Khanh Duong. All rights reserved.
//

import UIKit
import Braintree
import Alamofire
import SwiftyJSON

class PaymentVC: CustomViewController, BTDropInViewControllerDelegate, CardIOPaymentViewControllerDelegate, UIAlertViewDelegate {
    var braintree: Braintree?
    var paymentToken:String = ""
    let paymentTitle = "SnapArt total payment:"
    let paymentDescription = "SnapArt payment description."
    let paymentAmountText = "$\(ShoppingCartVC.paymentDetail.payment_amount)"
    var paymentAmount = ShoppingCartVC.paymentDetail.payment_amount
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let parentView:UIView! = self.navigationController?.view
        let api = Api()
        api.initWaiting(parentView)
        api.execute(.GET, url: ApiUrl.create_client_token_url, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                self.paymentToken = dataResult.data["token"].string!
                self.braintree = Braintree(clientToken: self.paymentToken)
            }else{
                var alert = Util().showAlert(dataResult.message, parrent: self)
                alert.tag = 0
                alert.delegate = self
            }
        })
        applyBackIcon()
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //braintree
    @IBAction func payClick(sender: AnyObject) {
        if(self.paymentToken != ""){
            var dropInViewController: BTDropInViewController = braintree!.dropInViewControllerWithDelegate(self)
            dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("userDidCancel"))
            
            //Customize the UI
            dropInViewController.summaryTitle = paymentTitle
            dropInViewController.summaryDescription = paymentDescription
            dropInViewController.displayAmount = paymentAmountText
            
            var navigationController: UINavigationController = UINavigationController(rootViewController: dropInViewController)
            
            self.presentViewController(navigationController, animated: true, completion: nil)
        }
    }
    
    func dropInViewController(viewController: BTDropInViewController!, didSucceedWithPaymentMethod paymentMethod: BTPaymentMethod!) {
        postNonce(paymentMethod.nonce)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func dropInViewControllerWillComplete(viewController: BTDropInViewController!) {
        
    }
    
    func dropInViewControllerDidCancel(viewController: BTDropInViewController!) {
        
    }
    
    
    func postNonce(paymentMethodNonce: String) {
        var parameters = [
            "payment_method_nonce": paymentMethodNonce,
            "amount" : paymentAmount,
            "payment_detail" : "\(ShoppingCartVC.paymentDetail.toJsonString())"
        ]
        ShoppingCartVC.paymentDetail.payment_method = 0
        ShoppingCartVC.paymentDetail.payment_method_nonce = paymentMethodNonce
        gotoPlaceOrder()
        //        let api = Api()
        //        let parentView:UIView! = self.navigationController?.view
        //        api.initWaiting(parentView)
        //        api.execute(.POST, url: ApiUrl.payment_url, parameters: parameters as! [String : AnyObject], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
        //            Util().showAlert(dataResult.message, parrent: self)
        //        })
    }
    
    func userDidCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //card.io
    
    @IBAction func scanCard(sender: AnyObject) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC.modalPresentationStyle = .FormSheet
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            ShoppingCartVC.paymentDetail.payment_method = 1
            ShoppingCartVC.paymentDetail.creditCard = [
                "number" : "\(info.cardNumber)",
                "number4last" : "\(info.redactedCardNumber)",
                "expirationMonth" : "\(info.expiryMonth)",
                "expirationYear" : "\(info.expiryYear)",
                "cvv" : "\(info.cvv)",
            ]
            gotoPlaceOrder()
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func gotoPlaceOrder(){
        let nv = Util().getControllerForStoryBoard("PlaceOrderVC") as! PlaceOrderVC
        self.navigationController?.pushViewController(nv, animated: true)
    }
    
}

