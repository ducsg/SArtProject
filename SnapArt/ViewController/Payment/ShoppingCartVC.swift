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
    var listCart: [Cart] = [Cart]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getListCart()
        // Do any additional setup after loading the view.
        self.applyBackIcon()
        self.automaticallyAdjustsScrollViewInsets = false
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
        return cell
    }
    
    func pressBtnPlus(sender: UIButton){
        let btnPlus = sender as! UIButton
        let index = Int(btnPlus.tag)
        listCart[index].quanlity = listCart[index].quanlity + 1
        self.tbOrder.reloadData()
        print(listCart[index].quanlity)
    }
    
    func pressBtnSubtract(sender: UIButton){
        let btnSubtract = sender as! UIButton
        let index = Int(btnSubtract.tag)
        listCart[index].quanlity = (listCart[index].quanlity - 1) < 1 ? 1 : listCart[index].quanlity - 1
        self.tbOrder.reloadData()
        print(listCart[index].quanlity)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
//            arrYears.removeObjectAtIndex(indexPath.row)
//            tableView.reloadData()
        }
    }
    func Event(sender:AnyObject!) -> Void  {
        let button = sender as! UIButton
        
    }

    private func getListCart(){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        api.execute(.POST, url: "", parameters: [APIKEY.ACCOUNT_ID: MemoryStoreData().getInt(APIKEY.ACCOUNT_ID)], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            self.listCart.append(Cart(frameUrl: "http://192.168.1.158:8080/trycode/css3/bbb.html", item: "Canvas 1", price: 6.9))
            self.listCart.append(Cart(frameUrl: "http://192.168.1.158:8080/trycode/css3/bbb.html", item: "Canvas 2", price: 6.9))
            self.listCart.append(Cart(frameUrl: "http://192.168.1.158:8080/trycode/css3/bbb.html", item: "Canvas 3", price: 10.98))
            self.tbOrder.reloadData()
        })
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
