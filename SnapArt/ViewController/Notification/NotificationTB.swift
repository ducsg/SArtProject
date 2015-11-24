//
//  NotificationVC.swift
//  SnapArt
//
//  Created by HD on 10/27/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

class NotificationTB: CustomTableViewController {

    @IBOutlet var tbNotification: UITableView!
    
    var listNotification = [Notification]()
    var current_page = 1
    var total_page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyBackIcon()
        self.tableView.allowsSelection = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.tapGest != nil {
            self.tapGest.enabled = false
        }
        getListNotification()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listNotification.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NotificationTBC = NotificationTBC.instanceFromNib()
        let notify: Notification = listNotification[indexPath.row]
        cell.lbTitle.text = notify.title
        cell.lbDatetime.text = notify.created_at
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == (listNotification.count-1 > 0 ? listNotification.count-1 : 0) ){
            if(self.current_page <= self.total_page){
                getListNotification()
            }
        }
    }
    
    private func getListNotification(){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        let parameters = [
            Api.PAGE:current_page,
            Api.ROW_PER_PAGE:10
        ]
        api.execute(.GET, url: ApiUrl.get_notification_url, parameters: parameters, isGetFullData: true, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                if(dataResult.data[Api.KEY_DATA].count > 0){
                    for i in 0...dataResult.data[Api.KEY_DATA].count-1 {
                        let data = dataResult.data[Api.KEY_DATA]
                        let notification = Notification(id: data[i]["id"].numberValue.integerValue, read_at: data[i]["read_at"].stringValue, created_at: Util().formatDatetime(data[i]["created_at"].stringValue, outputFormat: "MM/dd/yy HH:mm a"), transaction_id: data[i]["transaction_id"].numberValue.integerValue, type_of_notification: data[i]["type_of_notification"].numberValue.integerValue, action: data[i]["action"].numberValue.integerValue, title: data[i]["title"].stringValue)
                        self.listNotification.append(notification)
                    }
                    self.current_page++
                    self.total_page = dataResult.data[Api.PAGING][Api.TOTAL_PAGE].intValue
                    print("notification:: current_page: \(self.current_page), total_page: \(self.total_page)")
                    self.tbNotification.reloadData()
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
