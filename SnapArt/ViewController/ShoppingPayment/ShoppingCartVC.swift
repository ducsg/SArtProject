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
    //label title
    @IBOutlet weak var lbQuanlity: CustomLabelGotham!
    
    @IBOutlet weak var lbPreview: CustomLabelGotham!
    
    @IBOutlet weak var lbItem: CustomLabelGotham!
    
    @IBOutlet weak var lbPrice: CustomLabelGotham!
    
    @IBOutlet weak var tbOrder: UITableView!
    
    @IBOutlet weak var lbSubTotal: CustomLabelGotham!
    
    @IBOutlet weak var lbTotalCost: CustomLabelGothamBold!
    
    private let shoppingCost:Float = 0.99
    
    static var discount:Float = 0
    
    static var totalCost:Float = 0
    
    var listCart: [Cart] = [Cart]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getListCart()
        // Do any additional setup after loading the view.
        self.applyBackIcon()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tbOrder.allowsSelection = false
    }
    
    override func viewDidAppear(animated: Bool) {
        setFrameForTitleTable()
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
        let cart: Cart = listCart[indexPath.row]
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
            self.tbOrder.reloadData()
            self.resetCost()
            return true
        })
        btnDelete.tag = indexPath.row
        print(btnDelete.tag)
        cell.rightButtons = [btnDelete]
        cell.rightSwipeSettings.transition = MGSwipeTransition.Static
        
        return cell
    }
    
    func pressBtnPlus(sender: UIButton){
        let btnPlus = sender as! UIButton
        let index = Int(btnPlus.tag)
        listCart[index].quanlity = listCart[index].quanlity + 1
        self.tbOrder.reloadData()
        self.resetCost()
    }
    
    func pressBtnSubtract(sender: UIButton){
        let btnSubtract = sender as! UIButton
        let index = Int(btnSubtract.tag)
        listCart[index].quanlity = (listCart[index].quanlity - 1) < 1 ? 1 : listCart[index].quanlity - 1
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
                    let cart = Cart(frameUrl: dataResult.data[i]["link_picture"].stringValue, item: dataResult.data[i]["material"].stringValue, price: dataResult.data[i]["cost"].numberValue.floatValue)
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
    
    func resetCost(){
        let subTotal = self.getSubTotal()
        self.lbSubTotal.text = "$\(subTotal)"
        ShoppingCartVC.totalCost = subTotal + self.shoppingCost - ShoppingCartVC.discount
        self.lbTotalCost.text = "$\(ShoppingCartVC.totalCost)"
    }
    
    func getSubTotal() -> Float{
        var subTotal:Float = 0
        if(listCart.count > 0){
            for i in 0...listCart.count-1 {
            subTotal = subTotal + listCart[i].price * Float(listCart[i].quanlity)
            }
        }
        return subTotal
    }
    
    func setFrameForTitleTable(){
        let screenWidth = Util().getScreenWidth()
        //set position for quanlity label
        var rectQuanlity = lbQuanlity.frame
        rectQuanlity.origin.x = 15
        lbQuanlity.frame = rectQuanlity
        //set position for preview label
        var rectPreview = lbPreview.frame
        rectPreview.origin.x = CGFloat(screenWidth/10 * 2)
        lbPreview.frame = rectPreview
        //set item label
        var rectItem = lbItem.frame
        rectItem.origin.x = CGFloat(screenWidth/10 * 6)
        lbItem.frame = rectItem
        //set position for price
        var rectPrice = lbPrice.frame
        rectPrice.origin.x = CGFloat(screenWidth/10 * 8)
        lbPrice.frame = rectPrice
    }
    
    @IBAction func pressBtnShoppingQuestion(sender: AnyObject) {
        Util().showAlert(MESSAGES.SHOPPING.SHOPPING_QUESTION, parrent: self)
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
