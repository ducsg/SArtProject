//
//  ShoppingCartVC.swift
//  SnapArt
//
//  Created by HD on 10/27/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

class PlaceOrderVC: CustomViewController, UITableViewDataSource, UITableViewDelegate ,UIAlertViewDelegate {
    
    @IBOutlet weak var tbOrder: UITableView!
    
    @IBOutlet weak var lbSubTotal: CustomLabelGotham!
    
    @IBOutlet weak var lbTotalCost: CustomLabelGothamBold!
    
    @IBOutlet weak var lbDiscount: CustomLabelGotham!
    
    @IBOutlet weak var lbShipping: CustomLabelGotham!
    
    @IBOutlet weak var btnPurchase: CustomButton!
    
    @IBOutlet weak var layoutFooter: UIView!
    
    
    static var discount:Float = 0
    
    static var totalCost:Float = 0
    
    public static var isOrderReview = false
    public static var transaction = Transaction()
    
    var listCart: [Order] = [Order]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.applyBackIcon()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tbOrder.allowsSelection = false
        
        self.navigationItem.title = "Place Order"
        
        lbSubTotal.text = "$\(ShoppingCartVC.paymentDetail.subtotal)"
        lbDiscount.text = "$\(ShoppingCartVC.paymentDetail.discount)"
        lbShipping.text = "FREE"
        lbTotalCost.text = "$\(ShoppingCartVC.paymentDetail.payment_amount)"
        
        if(PlaceOrderVC.isOrderReview){
            self.navigationItem.title = "Order Review"
            btnPurchase.hidden = true
            getPaymentDetail()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tbOrder.reloadData()
        
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        PlaceOrderVC.isOrderReview = false
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(PlaceOrderVC.isOrderReview){
            return ShoppingCartVC.paymentDetail.list_order.count + 4
        }else{
            return ShoppingCartVC.paymentDetail.list_order.count + 3
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if(PlaceOrderVC.isOrderReview){
            if(indexPath.row == 0){
                return getTransactionCell()
            }
            if(indexPath.row == 1){
                return getBillingCell()
            }
            if(indexPath.row == 2){
                return getShippingCell()
            }
            if(indexPath.row == 3){
                return getTitleCell()
            }
        }else{
            if(indexPath.row == 0){
                return getBillingCell()
            }
            if(indexPath.row == 1){
                return getShippingCell()
            }
            if(indexPath.row == 2){
                return getTitleCell()
            }
        }
        let cell:ShoppingCartTBC = ShoppingCartTBC.instanceFromNib()
        var cart = Order()
        if(PlaceOrderVC.isOrderReview){
            cart = ShoppingCartVC.paymentDetail.list_order[indexPath.row-4]
        }else{
            cart = ShoppingCartVC.paymentDetail.list_order[indexPath.row-3]
        }
        cell.initCell(cart)
        cell.btnPlus.hidden = true
        cell.btnSubtract.hidden = true
        return cell
    }
    
    func getTransactionCell() -> PlaceOrderTransactionTBC{
        let cell:PlaceOrderTransactionTBC = PlaceOrderTransactionTBC.instanceFromNib()
        cell.lbTransactionId.text = "Order ID: \(PlaceOrderVC.transaction.order_id_full)"
        cell.lbPlacedDate.text = "Placed date: \(PlaceOrderVC.transaction.created_at)"
        cell.lbShippedDate.text = PlaceOrderVC.transaction.shipped_at == "" ? "" : "Shipped date: \(PlaceOrderVC.transaction.shipped_at)"
        cell.btnStatus.setTitleText(PlaceOrderVC.transaction.status)
        return cell
    }
    
    func getBillingCell() -> PlaceOrderTBC{
        let cell:PlaceOrderTBC = PlaceOrderTBC.instanceFromNib()
        cell.lbAdressTitle.text = "BILLING ADRRESS"
        cell.lbFullname.text = "\(ShoppingCartVC.paymentDetail.billing_address.firstName) \(ShoppingCartVC.paymentDetail.billing_address.lastName)"
        cell.lbAddress1.text = "\(ShoppingCartVC.paymentDetail.billing_address.address1)"
        cell.lbAddress2.text = "\(ShoppingCartVC.paymentDetail.billing_address.address2)"
        cell.lbCityState.text = "\(ShoppingCartVC.paymentDetail.billing_address.country), \(ShoppingCartVC.paymentDetail.billing_address.city), \(ShoppingCartVC.paymentDetail.billing_address.state), \(ShoppingCartVC.paymentDetail.billing_address.postalCose)"
        cell.btnEdit.addTarget(self, action: "pressBtnEditBilling:", forControlEvents: UIControlEvents.TouchUpInside)
        if(PlaceOrderVC.isOrderReview){
            cell.btnEdit.hidden = true
        }
        return cell
    }
    
    func getShippingCell() -> PlaceOrderTBC{
        let cell:PlaceOrderTBC = PlaceOrderTBC.instanceFromNib()
        cell.lbAdressTitle.text = "SHIPPING ADRRESS"
        cell.lbFullname.text = "\(ShoppingCartVC.paymentDetail.shipping_address.firstName) \(ShoppingCartVC.paymentDetail.shipping_address.lastName)"
        cell.lbAddress1.text = "\(ShoppingCartVC.paymentDetail.shipping_address.address1)"
        cell.lbAddress2.text = "\(ShoppingCartVC.paymentDetail.shipping_address.address2)"
        cell.lbCityState.text = "\(ShoppingCartVC.paymentDetail.shipping_address.country), \(ShoppingCartVC.paymentDetail.shipping_address.city), \(ShoppingCartVC.paymentDetail.shipping_address.state), \(ShoppingCartVC.paymentDetail.shipping_address.postalCose)"
        cell.btnEdit.addTarget(self, action: "pressBtnEditShipping:", forControlEvents: UIControlEvents.TouchUpInside)
        if(PlaceOrderVC.isOrderReview){
            cell.btnEdit.hidden = true
        }
        return cell
    }
    
    func getTitleCell() -> PlaceOrderTitleTBC{
        let cell:PlaceOrderTitleTBC = PlaceOrderTitleTBC.instanceFromNib()
        cell.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        return cell
    }
    
    func pressBtnEditBilling(sender: AnyObject){
        BuyIt2TB.buy2 = 1
        let nv = Util().getControllerForStoryBoard("BuyIt2TB") as! BuyIt2TB
        self.navigationController?.pushViewController(nv, animated: true)
    }
    
    func pressBtnEditShipping(sender: AnyObject){
        BuyIt2TB.buy2 = 2
        let nv = Util().getControllerForStoryBoard("BuyIt2TB") as! BuyIt2TB
        self.navigationController?.pushViewController(nv, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(PlaceOrderVC.isOrderReview){
            if(indexPath.row == 0){
                return 70;
            }
            if(indexPath.row > 0 && indexPath.row <= 2){
                return 130;
            }
            if(indexPath.row == 3){
                return 44
            }
            if(indexPath.row > 3){
                return 130
            }
        }else{
            if(indexPath.row <= 1){
                return 130;
            }else if(indexPath.row == 2){
                return 44
            }else{
                return 130
            }
        }
        return 130
    }
    
    @IBAction func pressBtnPurchase(sender: AnyObject) {
        PlaceOrderVC.isOrderReview = false
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
                    var alert = Util().showAlert(dataResult.message, parrent: self)
                    alert.tag = 0
                    alert.delegate = self
                }else{
                    var alert = Util().showAlert(dataResult.message, parrent: self)
                    alert.tag = 1
                    alert.delegate = self
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
                    var alert = Util().showAlert(dataResult.message, parrent: self)
                    alert.tag = 0
                    alert.delegate = self
                }else{
                    var alert = Util().showAlert(dataResult.message, parrent: self)
                    alert.tag = 1
                    alert.delegate = self
                }
            })
        }
    }
    
    func gotoHome(){
        NSNotificationCenter.defaultCenter().postNotificationName(MESSAGES.NOTIFY.COMEBACKHOME, object: nil)
    }
    
    func gotoPaymentMethod(){
        let nv = Util().getControllerForStoryBoard("PaymentVC") as! PaymentVC
        self.navigationController?.pushViewController(nv, animated: true)
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(alertView.tag == 0){
            gotoHome()
        }
        if(alertView.tag == 1){
            gotoPaymentMethod()
        }
    }
    
    
    func getPaymentDetail(){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        api.execute(.GET, url: ApiUrl.get_transaction_detail_url, parameters: ["id":"\(PlaceOrderVC.transaction.id)"], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                ShoppingCartVC.paymentDetail = PaymentDetail().getObjectFromString(dataResult.data.stringValue)
                let subTotal = ShoppingCartVC.paymentDetail.subtotal
                let discount:Float = Float(subTotal*ShoppingCartVC.discount/100).roundToPlaces(2)
                self.lbSubTotal.text = "$\(subTotal)"
                ShoppingCartVC.totalCost = (subTotal + ShoppingCartVC.paymentDetail.shopping_cost - discount).roundToPlaces(2)
                self.lbTotalCost.text = "$\(ShoppingCartVC.totalCost)"
                //set data for payment
                ShoppingCartVC.paymentDetail.subtotal = subTotal
                ShoppingCartVC.paymentDetail.payment_amount = ShoppingCartVC.totalCost
                ShoppingCartVC.paymentDetail.discount = discount
                self.lbDiscount.text = "$\(discount)"
                self.tbOrder.reloadData()
            }else{
                Util().showAlert(dataResult.message, parrent: self)
            }
        })
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
