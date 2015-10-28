//
//  ShoppingCartVC.swift
//  SnapArt
//
//  Created by HD on 10/27/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class ShoppingCartVC: CustomViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tbOrder: UITableView!
    var listCart: [Cart] = [Cart]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getListCart()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listCart.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: ShoppingCartTBC = tableView.dequeueReusableCellWithIdentifier("ShoppingCartTBC") as! ShoppingCartTBC
        let cart: Cart = listCart[indexPath.row]
        cell.initCell(cart)
        return cell
    }

    private func getListCart(){
        listCart.append(Cart(price: 9.9))
        listCart.append(Cart(price: 6.9))
        listCart.append(Cart(price: 10.98))
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
