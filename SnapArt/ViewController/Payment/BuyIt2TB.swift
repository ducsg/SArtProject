//
//  BuyItVC.swift
//  SnapArt
//
//  Created by HD on 11/4/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class BuyIt2TB: CustomTableViewController, UITextFieldDelegate {

    @IBOutlet weak var tfFirstName: CustomTextField!
    @IBOutlet weak var tfLastName: CustomTextField!
    @IBOutlet weak var tfAddress1: CustomTextField!
    @IBOutlet weak var tfAddress2: CustomTextField!
    @IBOutlet weak var tfCity: CustomTextField!
    @IBOutlet weak var tfState: CustomTextField!
    @IBOutlet weak var tfPostalCode: CustomTextField!
    @IBOutlet weak var tfCountry: CustomTextField!
    
    @IBOutlet weak var lbTitle: CustomLabelGothamBold!
    
    @IBOutlet weak var lbDes: CustomLabel!
    @IBOutlet weak var lbError: CustomLabel!
    
    var errorText = "Please fill out all required fields."
    var listFieldRequire = [CustomTextField]()
    var useBillingAddress:Bool = false
    var shippingAddressData = Address()
    var billingAddressData = Address()
    var postCodeTemp:Int = 0
    
    public static var buy2 = 0
    public var billingTitle = "BILLING ADDRESS"
    public var billingDes = "The address associated with your payment method."
    public var shippingTitle = "SHIPPING ADDRESS"
    public var shippingDes = "The address you'd like us to sent your finished framed piece."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listFieldRequire = [tfFirstName, tfLastName, tfAddress1, tfCountry]
        // Do any additional setup after loading the view.
        tfCountry.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        applyBackIcon()
        tfPostalCode.keyboardType = UIKeyboardType.NumberPad
        
        if(BuyIt2TB.buy2 == 1){
            lbTitle.text = billingTitle
            lbDes.text = billingDes
            //set data
            self.tfFirstName.text! = ShoppingCartVC.paymentDetail.billing_address.firstName
            self.tfLastName.text! = ShoppingCartVC.paymentDetail.billing_address.lastName
            self.tfAddress1.text! = ShoppingCartVC.paymentDetail.billing_address.address1
            self.tfAddress2.text! = ShoppingCartVC.paymentDetail.billing_address.address2
            self.tfCity.text! = ShoppingCartVC.paymentDetail.billing_address.city
            self.tfState.text! = ShoppingCartVC.paymentDetail.billing_address.state
            self.tfCountry.text! = ShoppingCartVC.paymentDetail.billing_address.country
            self.tfPostalCode.text! = ShoppingCartVC.paymentDetail.billing_address.postalCose
        }
        if(BuyIt2TB.buy2 == 2){
            lbTitle.text = shippingTitle
            lbDes.text = shippingDes
            //set data
            self.tfFirstName.text! = ShoppingCartVC.paymentDetail.shipping_address.firstName
            self.tfLastName.text! = ShoppingCartVC.paymentDetail.shipping_address.lastName
            self.tfAddress1.text! = ShoppingCartVC.paymentDetail.shipping_address.address1
            self.tfAddress2.text! = ShoppingCartVC.paymentDetail.shipping_address.address2
            self.tfCity.text! = ShoppingCartVC.paymentDetail.shipping_address.city
            self.tfState.text! = ShoppingCartVC.paymentDetail.shipping_address.state
            self.tfCountry.text! = ShoppingCartVC.paymentDetail.shipping_address.country
            self.tfPostalCode.text! = ShoppingCartVC.paymentDetail.shipping_address.postalCose
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func pressBtnContinue(sender: AnyObject) {
        if(BuyIt2TB.buy2 == 0){
            if(Util().checkRequireField(listFieldRequire)){
                lbError.text = ""
                self.getShippingData()
                let nv = Util().getControllerForStoryBoard("PaymentVC") as! PaymentVC
                self.navigationController?.pushViewController(nv, animated: true)
                return
            }else{
                lbError.text = errorText
                lbError.textColor = UIColor.redColor()
                return
            }
        }
        if(BuyIt2TB.buy2 == 1){
            self.getBillingData()
        }
        if(BuyIt2TB.buy2 == 2){
            self.getShippingData()
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getShippingData(){
        shippingAddressData.firstName = self.tfFirstName.text!
        shippingAddressData.lastName = self.tfLastName.text!
        shippingAddressData.address1 = self.tfAddress1.text!
        shippingAddressData.address2 = self.tfAddress2.text!
        shippingAddressData.city = self.tfCity.text!
        shippingAddressData.state = self.tfState.text!
        shippingAddressData.country = self.tfCountry.text!
        shippingAddressData.postalCose = self.tfPostalCode.text!
        
        ShoppingCartVC.paymentDetail.shipping_address = shippingAddressData
        print(ShoppingCartVC.paymentDetail.toJsonString())
    }
    func getBillingData(){
        billingAddressData.firstName = self.tfFirstName.text!
        billingAddressData.lastName = self.tfLastName.text!
        billingAddressData.address1 = self.tfAddress1.text!
        billingAddressData.address2 = self.tfAddress2.text!
        billingAddressData.city = self.tfCity.text!
        billingAddressData.state = self.tfState.text!
        billingAddressData.country = self.tfCountry.text!
        billingAddressData.postalCose = self.tfPostalCode.text!
        
        ShoppingCartVC.paymentDetail.billing_address = billingAddressData
        if(useBillingAddress){
            ShoppingCartVC.paymentDetail.shipping_address = billingAddressData
        }
    }
    
    func showpicker() -> Void {
        self.tfPostalCode.resignFirstResponder()
        let countryList:[String] = Util().getCountryList()
        let picker = ActionSheetStringPicker(title: "", rows: countryList, initialSelection: self.postCodeTemp, doneBlock: {picker, value, index in
            self.tfCountry.text = String(index)
            self.postCodeTemp = countryList.indexOf(String(index))!
            
            return
            }, cancelBlock: {ActionStringCancelBlock in
                
                return
            }, origin: tfCountry.superview)
        picker.showActionSheetPicker()
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == self.tfCountry {
            self.tableView.endEditing(true)
            showpicker();
            return false
        }
        return true
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
