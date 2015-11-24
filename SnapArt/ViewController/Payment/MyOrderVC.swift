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
    
    var current_page = 1
    var total_page = 1
    static var isReload = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyBackIcon()
        self.title = self.TITTLE
//        let nib = UINib(nibName: "MyOrderCell", bundle: nil)
//        myOrderTb.registerNib(nib, forCellReuseIdentifier: "cell")
        myOrderTb.registerClass(MyOrderCell.self, forCellReuseIdentifier: "MyOrderCell")
        myOrderTb.delegate = self
        myOrderTb.dataSource = self

        
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        MyOrderVC.isReload = true
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
        if(MyOrderVC.isReload){
            getTransactionList()
        }
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
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == (transactionList.count-1 > 0 ? transactionList.count-1 : 0) ){
            if(self.current_page <= self.total_page){
                getTransactionList()
            }
        }
    }
    
    private func getTransactionList(){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        let parameters = [
            Api.PAGE:current_page,
            Api.ROW_PER_PAGE:10
        ]
        api.execute(.GET, url: ApiUrl.get_transaction_url, parameters: parameters, isGetFullData: true, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                if(dataResult.data[Api.KEY_DATA].count > 0){
                    for i in 0...dataResult.data[Api.KEY_DATA].count-1 {
                        let data = dataResult.data[Api.KEY_DATA]
                        let dateStr = Util().formatDatetime(data[i]["created_at"].stringValue, outputFormat: "MM/dd/yy")
                        var shipped_at = ""
                        if(data[i]["shipped_at"].stringValue != ""){
                            shipped_at = Util().formatDatetime(data[i]["shipped_at"].stringValue, outputFormat: "MM/dd/yy")
                        }
                        let transaction = Transaction(id: data[i]["id"].numberValue.integerValue, imgUrl: data[i]["img_url"].stringValue, created_at: dateStr, shipped_at: shipped_at, code: data[i]["order_id_full"].stringValue, status: data[i]["status"].stringValue)
                        self.transactionList.append(transaction)
                        print(data[i]["img_url"].stringValue)
                    }
                    self.current_page++
                    self.total_page = dataResult.data[Api.PAGING][Api.TOTAL_PAGE].intValue
                    print("orders:: current_page: \(self.current_page), total_page: \(self.total_page)")
                    self.myOrderTb.reloadData()
                }
            }else{
                self.current_page--
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
