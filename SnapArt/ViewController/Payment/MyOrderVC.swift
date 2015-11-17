//
//  MyOrderVC.swift
//  SnapArt
//
//  Created by HD on 11/13/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyOrderVC: CustomViewController , UITableViewDataSource,UITableViewDelegate  {
    @IBOutlet weak var titlesView: HeaderView!
    @IBOutlet weak var myOrderTb: UITableView!
    let TITLES = ["Preview","Date","Code","Status"]
    private var TITTLE = "My Orders"
    private var transactionList = [Transaction]()
    override func viewDidLoad() {
        super.viewDidLoad()
        applyBackIcon()
        self.title = self.TITTLE
//        let nib = UINib(nibName: "MyOrderCell", bundle: nil)
//        myOrderTb.registerNib(nib, forCellReuseIdentifier: "cell")
        myOrderTb.registerClass(MyOrderCell.self, forCellReuseIdentifier: "MyOrderCell")
        myOrderTb.delegate = self
        myOrderTb.dataSource = self

        getTransactionList()
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        titlesView.addTitles(TITLES)
    }
    override func viewDidAppear(animated: Bool) {
        myOrderTb.reloadData()
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionList.count
    }
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MyOrderCell = tableView.dequeueReusableCellWithIdentifier("MyOrderCell") as! MyOrderCell
        cell.setTransaction(self.transactionList[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        PlaceOrderVC.isOrderReview = true
        PlaceOrderVC.transaction = transactionList[indexPath.row]
        let nv = Util().getControllerForStoryBoard("PlaceOrderVC") as! PlaceOrderVC
        self.navigationController?.pushViewController(nv, animated: true)
    }
    private func getTransactionList(){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        let parameters = ["page":1,"row_per_page":20]
        api.execute(.GET, url: ApiUrl.get_transaction_url, parameters: parameters, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                if(dataResult.data.count > 0){
                    for i in 0...dataResult.data.count-1 {
                        let dateStr = Util().formatDatetime(dataResult.data[i]["created_at"].stringValue, outputFormat: "MM/dd/yyyy")
                        var shipped_at = ""
                        if(dataResult.data[i]["shipped_at"].stringValue != ""){
                            shipped_at = Util().formatDatetime(dataResult.data[i]["shipped_at"].stringValue, outputFormat: "MM/dd/yyyy")
                        }
                        let transaction = Transaction(id: dataResult.data[i]["id"].numberValue.integerValue, imgUrl: dataResult.data[i]["img_url"].stringValue, created_at: dateStr, shipped_at: shipped_at, code: dataResult.data[i]["order_id_full"].stringValue, status: dataResult.data[i]["status"].stringValue)
                        self.transactionList.append(transaction)
                        print(dataResult.data[i]["img_url"].stringValue)
                    }
                    self.myOrderTb.reloadData()
                }
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
