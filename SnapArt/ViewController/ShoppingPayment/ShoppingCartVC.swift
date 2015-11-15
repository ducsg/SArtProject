//
//  ShoppingCartVC.swift
//  SnapArt
//
//  Created by HD on 10/27/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShoppingCartVC: CustomViewController, UITableViewDataSource, UITableViewDelegate {
    //all data for payment
    public static var paymentDetail = PaymentDetail()
    //label title
    
    @IBOutlet weak var tbOrder: UITableView!
    
    @IBOutlet weak var lbSubTotal: CustomLabelGotham!
    
    @IBOutlet weak var lbTotalCost: CustomLabelGothamBold!
    
    @IBOutlet weak var lbDiscount: CustomLabelGotham!
    
    @IBOutlet weak var lbShipping: CustomLabelGotham!
    
    @IBOutlet weak var headerView: HeaderView!
    
    static var discount:Float = 0
    
    static var totalCost:Float = 0
    let TITLES = ["Preview","Date","Code","Status"]

    var listCart: [Order] = [Order]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getListCart()
        // Do any additional setup after loading the view.
        self.applyBackIcon()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tbOrder.allowsSelection = false
        ShoppingCartVC.discount = 0
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetCost:", name:MESSAGES.NOTIFY.RESET_COST, object: nil)
 
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(true)
        headerView.addTitles(TITLES)
//        if(Util().getCountryCode() == "US"){
            lbShipping.text = "FREE"
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
        return listCart.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:ShoppingCartTBC = ShoppingCartTBC.instanceFromNib()
        let cart: Order = listCart[indexPath.row]
        cell.initCell(cart)
        cell.btnPlus.tag = indexPath.row
        cell.btnSubtract.tag = indexPath.row
        cell.btnPlus.addTarget(self, action: "pressBtnPlus:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.btnSubtract.addTarget(self, action: "pressBtnSubtract:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //configure right buttons
        var btnDelete = MGSwipeButton(title: "", icon: UIImage (named:"ic_delete"), backgroundColor: UIColor.redColor(), callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            let indexRow:Int = self.tbOrder.indexPathForCell(sender)!.row
            self.listCart.removeAtIndex(indexRow)
            tableView.deleteRowsAtIndexPaths([self.tbOrder.indexPathForCell(sender)!], withRowAnimation: UITableViewRowAnimation.Left)
            self.resetCost()
            return true
        })
        btnDelete.tag = indexPath.row
        btnDelete.setPadding(30)
        print(btnDelete.tag)
        cell.rightButtons = [btnDelete]
        cell.rightSwipeSettings.transition = MGSwipeTransition.Static
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100;
    }
    
    func pressBtnPlus(sender: UIButton){
        let btnPlus = sender as! UIButton
        let index = Int(btnPlus.tag)
        listCart[index].quantity = listCart[index].quantity + 1
        self.tbOrder.reloadData()
        self.resetCost()
    }
    
    func pressBtnSubtract(sender: UIButton){
        let btnSubtract = sender as! UIButton
        let index = Int(btnSubtract.tag)
        listCart[index].quantity = (listCart[index].quantity - 1) < 1 ? 1 : listCart[index].quantity - 1
        self.tbOrder.reloadData()
        self.resetCost()
    }

    func Event(sender:AnyObject!) -> Void  {
        let button = sender as! UIButton
    }

    private func getListCart(){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        api.execute(.GET, url: ApiUrl.my_orders_url, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                if(dataResult.data.count > 0){
                    for i in 0...dataResult.data.count-1 {
                        let cart = Order(id: dataResult.data[i]["id"].numberValue.integerValue, quantity: dataResult.data[i]["quantity"].numberValue.integerValue,frameUrl: dataResult.data[i]["link_picture"].stringValue, item: dataResult.data[i]["material"].stringValue, price: dataResult.data[i]["cost"].numberValue.floatValue, size: dataResult.data[i]["size"].stringValue)
                    self.listCart.append(cart)
                    self.tbOrder.reloadData()
                    }
                }
                self.resetCost()
            }else{
                Util().showAlert(dataResult.message, parrent: self)
            }
            
        })
    }
    
    func resetCost(sender:AnyObject = "") -> Void{
        let subTotal = self.getSubTotal()
        let discount:Float = Float(subTotal*ShoppingCartVC.discount/100).roundToPlaces(2)
        self.lbSubTotal.text = "$\(subTotal)"
        ShoppingCartVC.totalCost = (subTotal + ShoppingCartVC.paymentDetail.shopping_cost - discount).roundToPlaces(2)
        self.lbTotalCost.text = "$\(ShoppingCartVC.totalCost)"
        //set data for payment
        ShoppingCartVC.paymentDetail.subtotal = subTotal
        ShoppingCartVC.paymentDetail.payment_amount = ShoppingCartVC.totalCost
        ShoppingCartVC.paymentDetail.discount = discount
        lbDiscount.text = "$\(discount)"
    }
    
    
    func getSubTotal() -> Float{
        var subTotal:Float = 0
        if(listCart.count > 0){
            for i in 0...listCart.count-1 {
            subTotal = subTotal + listCart[i].price * Float(listCart[i].quantity)
            }
        }
        return subTotal.roundToPlaces(2)
    }
 
    
    @IBAction func pressBtnShoppingQuestion(sender: AnyObject) {
        Util().showAlert(MESSAGES.SHOPPING.SHOPPING_QUESTION, parrent: self)
    }
    
    @IBAction func pressBtnAddAnotherFrame(sender: AnyObject) {
        let nv = Util().getControllerForStoryBoard("UploadViewVC") as! CustomNavigationController
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    
    @IBAction func pressBtnCheckOut(sender: AnyObject) {
        if(self.listCart.count > 0){
            saveDataForPayment()
            let nv = Util().getControllerForStoryBoard("BuyItTB") as! BuyItTB
            self.navigationController?.pushViewController(nv, animated: true)
        }
    }
    
    func saveDataForPayment(){
        ShoppingCartVC.paymentDetail.list_order = listCart
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
