//
//  BuyItVC.swift
//  SnapArt
//
//  Created by HD on 11/4/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class BuyIt2TB: CustomTableViewController {

    @IBOutlet weak var tfFirstName: CustomTextField!
    @IBOutlet weak var tfLastName: CustomTextField!
    @IBOutlet weak var tfAddress1: CustomTextField!
    @IBOutlet weak var tfAddress2: CustomTextField!
    @IBOutlet weak var tfCity: CustomTextField!
    @IBOutlet weak var tfState: CustomTextField!
    @IBOutlet weak var tfPostalCode: CustomTextField!
    @IBOutlet weak var tfCountry: CustomTextField!
    
    var listFieldRequire = [CustomTextField]()
    var useBillingAddress:Bool = false
    var shippingAddressData = Address()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listFieldRequire = [tfFirstName, tfLastName, tfAddress1, tfCity, tfState, tfPostalCode, tfCountry]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        applyBackIcon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func pressBtnContinue(sender: AnyObject) {
        if(Util().checkRequireField(listFieldRequire)){
            getFillingData()
            let nv = Util().getControllerForStoryBoard("PaymentVC") as! PaymentVC
            self.navigationController?.pushViewController(nv, animated: true)
        }
    }
    
    func getFillingData(){
        shippingAddressData.firstName = self.tfFirstName.text!
        shippingAddressData.lastName = self.tfLastName.text!
        shippingAddressData.address1 = self.tfAddress1.text!
        shippingAddressData.address2 = self.tfAddress2.text!
        shippingAddressData.city = self.tfCity.text!
        shippingAddressData.country = self.tfCountry.text!
        shippingAddressData.postalCose = self.tfPostalCode.text!
        
        ShoppingCartVC.paymentDetail.shipping_address = shippingAddressData
        print(ShoppingCartVC.paymentDetail.toJsonString())
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
