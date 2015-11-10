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
    override func viewDidLoad() {
        super.viewDidLoad()
        applyBackIcon()
        getListNotification()
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
        return 50
    }
    
    private func getListNotification(){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        let parameters = [
            "page":1,
            "row_per_page":20
        ]
        api.execute(.GET, url: ApiUrl.get_notification_url, parameters: parameters, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                if(dataResult.data.count > 0){
                    for i in 0...dataResult.data.count-1 {
                        let notification = Notification(id: dataResult.data[i]["id"].numberValue.integerValue, read_at: dataResult.data[i]["read_at"].stringValue, created_at: dataResult.data[i]["created_at"].stringValue, transaction_id: dataResult.data[i]["transaction_id"].numberValue.integerValue, type_of_notification: dataResult.data[i]["type_of_notification"].numberValue.integerValue, action: dataResult.data[i]["action"].numberValue.integerValue, title: dataResult.data[i]["title"].stringValue)
                        self.listNotification.append(notification)
                        self.tbNotification.reloadData()
                    }
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
