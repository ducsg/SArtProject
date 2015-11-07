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
        return ShoppingCartVC.paymentDetail.list_order.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:ShoppingCartTBC = ShoppingCartTBC.instanceFromNib()
        let cart: Order = ShoppingCartVC.paymentDetail.list_order[indexPath.row]
        cell.initCell(cart)
        cell.btnPlus.tag = indexPath.row
        cell.btnSubtract.tag = indexPath.row
        cell.btnPlus.addTarget(self, action: "pressBtnPlus:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.btnSubtract.addTarget(self, action: "pressBtnSubtract:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    @IBAction func pressBtnCheckOut(sender: AnyObject) {
//        let nv = Util().getControllerForStoryBoard("PaymentVC") as! CustomNavigationController
//        self.navigationController?.pushViewController(nv, animated: true)
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
