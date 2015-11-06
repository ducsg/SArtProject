//
//  BuyItVC.swift
//  SnapArt
//
//  Created by HD on 11/4/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class BuyItTB: CustomTableViewController {

    @IBOutlet weak var tfFirstName: CustomTextField!
    @IBOutlet weak var tfLastName: CustomTextField!
    @IBOutlet weak var tfAddress1: CustomTextField!
    @IBOutlet weak var tfAddress2: CustomTextField!
    @IBOutlet weak var tfCity: CustomTextField!
    @IBOutlet weak var tfState: CustomTextField!
    @IBOutlet weak var tfPostalCode: CustomTextField!
    @IBOutlet weak var tfCountry: CustomTextField!
    @IBOutlet weak var cbUseBillingAddress: CustomLabelButtonGotham!
    
    var listFieldRequire = [CustomTextField]()
    var useBillingAddress:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listFieldRequire = [tfFirstName, tfLastName, tfAddress1, tfAddress2, tfCity, tfState, tfPostalCode, tfCountry]
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

    
    @IBAction func pressBtnUseBilling(sender: AnyObject) {
        useBillingAddress = !useBillingAddress
        if(useBillingAddress){
            cbUseBillingAddress.setImage(UIImage(named: "ic_checked.png"), forState: .Normal)
        }else{
            cbUseBillingAddress.setImage(UIImage(named: "ic_unchecked.png"), forState: .Normal)
        }
    }
    @IBAction func pressBtnContinue(sender: AnyObject) {
        if(Util().checkRequireField(listFieldRequire)){
            
        }
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
