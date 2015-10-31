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
    
    @IBOutlet weak var tbOrder: UITableView!
    var listCart: [Cart] = [Cart]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getListCart()
        // Do any additional setup after loading the view.
        self.applyBackIcon()
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
        let  buton = UIButton()
        buton.tag = indexPath.row
        buton.addTarget(self, action: "Event:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
