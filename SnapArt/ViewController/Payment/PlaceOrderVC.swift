//
//  ShoppingCartVC.swift
//  SnapArt
//
//  Created by HD on 10/27/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

class PlaceOrderVC: CustomViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tbOrder: UITableView!
    
    @IBOutlet weak var lbSubTotal: CustomLabelGotham!
    
    @IBOutlet weak var lbTotalCost: CustomLabelGothamBold!
    
    @IBOutlet weak var lbDiscount: CustomLabelGotham!
    
    
    static var discount:Float = 0
    
    static var totalCost:Float = 0
    
    var listCart: [Order] = [Order]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.applyBackIcon()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tbOrder.allowsSelection = false
        
        self.navigationItem.title = "Place Order"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(true)
        //        if(Util().getCountryCode() == "US"){
        lbDiscount.text = "FREE"
        lbSubTotal.text = "\(ShoppingCartVC.paymentDetail.subtotal)"
        lbTotalCost.text = "\(ShoppingCartVC.paymentDetail.payment_amount)"
        //        }
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ShoppingCartVC.paymentDetail.list_order.count + 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if(indexPath.row == 0){
            let cell:PlaceOrderTBC = PlaceOrderTBC.instanceFromNib()
            cell.lbAdressTitle.text = "BILLING ADRRESS"
            cell.lbFullname.text = "\(ShoppingCartVC.paymentDetail.billing_address.firstName) \(ShoppingCartVC.paymentDetail.billing_address.lastName)"
            cell.lbAddress1.text = "\(ShoppingCartVC.paymentDetail.billing_address.address1)"
            cell.lbAddress2.text = "\(ShoppingCartVC.paymentDetail.billing_address.address2)"
            cell.lbCityState.text = "\(ShoppingCartVC.paymentDetail.billing_address.country), \(ShoppingCartVC.paymentDetail.billing_address.city), \(ShoppingCartVC.paymentDetail.billing_address.state), \(ShoppingCartVC.paymentDetail.billing_address.postalCose)"
            return cell
        }
        if(indexPath.row == 1){
            let cell:PlaceOrderTBC = PlaceOrderTBC.instanceFromNib()
            cell.lbAdressTitle.text = "SHIPPING ADRRESS"
            cell.lbFullname.text = "\(ShoppingCartVC.paymentDetail.shipping_address.firstName) \(ShoppingCartVC.paymentDetail.shipping_address.lastName)"
            cell.lbAddress1.text = "\(ShoppingCartVC.paymentDetail.shipping_address.address1)"
            cell.lbAddress2.text = "\(ShoppingCartVC.paymentDetail.shipping_address.address2)"
            cell.lbCityState.text = "\(ShoppingCartVC.paymentDetail.shipping_address.country), \(ShoppingCartVC.paymentDetail.shipping_address.city), \(ShoppingCartVC.paymentDetail.shipping_address.state), \(ShoppingCartVC.paymentDetail.shipping_address.postalCose)"
            return cell
        }
        let cell:ShoppingCartTBC = ShoppingCartTBC.instanceFromNib()
        let cart: Order = ShoppingCartVC.paymentDetail.list_order[indexPath.row-2]
        cell.initCell(cart)
        cell.btnPlus.hidden = true
        cell.btnSubtract.hidden = true
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(indexPath.row > 1){
           return 100;
        }else{
            return 130
        }
    }
    
    @IBAction func pressBtnPurchase(sender: AnyObject) {
        let payment_detail:String = ShoppingCartVC.paymentDetail.toJsonString()!
        if(ShoppingCartVC.paymentDetail.payment_method == 0){
            ShoppingCartVC.paymentDetail.creditCard = [String:String]()
            var parameters = [
                "payment_method_nonce": ShoppingCartVC.paymentDetail.payment_method_nonce,
                "amount" : ShoppingCartVC.paymentDetail.payment_amount,
                "payment_detail" : payment_detail
            ]
            let api = Api()
            let parentView:UIView! = self.navigationController?.view
            api.initWaiting(parentView)
            api.execute(.POST, url: ApiUrl.payment_url, parameters: parameters as! [String : AnyObject], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
                if(dataResult.success){
//                    self.gotoHome()
                    Util().showAlert(dataResult.message, parrent: self)
                }else{
                    Util().showAlert(dataResult.message, parrent: self)
                }
            })
        }else{
            let creditCard = ShoppingCartVC.paymentDetail.creditCard
            ShoppingCartVC.paymentDetail.creditCard["number"] = ""
            let parameters = [
                "amount" : ShoppingCartVC.paymentDetail.payment_amount,
                "creditCard": creditCard,
                "payment_detail" : payment_detail
            ]
            let api = Api()
            let parentView:UIView! = self.navigationController?.view
            api.initWaiting(parentView)
            api.execute(.POST, url: ApiUrl.payment_scanner_url, parameters: parameters as! [String : AnyObject], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
                if(dataResult.success){
//                    self.gotoHome()
                    Util().showAlert(dataResult.message, parrent: self)
                }else{
                    Util().showAlert(dataResult.message, parrent: self)
                }
            })
        }
    }
    
    func gotoHome(){
                let nv = Util().getControllerForStoryBoard("MenuNaviController") as! CustomNavigationController
                self.navigationController?.pushViewController(nv, animated: true)
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
