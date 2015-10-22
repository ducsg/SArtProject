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

class PaymentVC: UIViewController, BTDropInViewControllerDelegate{
    var braintree: Braintree?
    var paymentToken:String = ""
    let paymentTitle = "SnapArt total payment:"
    let paymentDescription = "Khanh Duong implement payment method for SnapArt."
    let paymentAmount = "$1"
    
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
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func payClick(sender: AnyObject) {
        var dropInViewController: BTDropInViewController = braintree!.dropInViewControllerWithDelegate(self)
        dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("userDidCancel"))
        
        //Customize the UI
        dropInViewController.summaryTitle = paymentTitle
        dropInViewController.summaryDescription = paymentDescription
        dropInViewController.displayAmount = paymentAmount
        
        var navigationController: UINavigationController = UINavigationController(rootViewController: dropInViewController)
        
        self.presentViewController(navigationController, animated: true, completion: nil)
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
        var parameters = ["payment_method_nonce": paymentMethodNonce, "amount" : 1]
        Alamofire.request(.POST, "http://demo.innoria.com/snapart/api/payments/pay", headers: ["Authorization":"Basic c25hcGFydEBhZG1pbi5jb206YWRtaW4xMjM0"], parameters: parameters as! [String : AnyObject])
            .response { request, response, data, error in
                print(request)
                print(response)
                print(data)
                print(error)
        }
        
    }
    
    func userDidCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

