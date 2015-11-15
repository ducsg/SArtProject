//
//  MyAccountTB.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/10/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class MyAccountTB: CustomTableViewController {
    
    let myAccountList = ["Email","Password","Change password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.scrollEnabled = false
        self.tableView.allowsSelection = true
        self.tableView.separatorColor = UIColor.clearColor()
        applyBackIcon()
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.tapGest != nil {
            self.tapGest.enabled = false
        }
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return myAccountList.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyAccountCell", forIndexPath: indexPath)
        cell.textLabel!.font = SA_STYPE.FONT_GOTHAM
        cell.textLabel!.textColor = SA_STYPE.TEXT_LABEL_COLOR
        cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.textLabel!.numberOfLines = 0
        cell.backgroundColor = UIColor.clearColor()
        let emailStr = MemoryStoreData().getString(MemoryStoreData.user_email)

        switch indexPath.row {
        case 0:
            cell.textLabel!.text = "\(myAccountList[indexPath.row]):  \(emailStr)"
            break;
        case 1:
            cell.textLabel!.text = "\(myAccountList[indexPath.row]):  ••••••••"
            break;
        case 2:
            cell.textLabel?.hidden = true
            let rect = CGRectMake(5, 0, 150, 44)
            let btn = CustomButton(frame: rect)
            btn.setTitle("\(myAccountList[indexPath.row])", forState: UIControlState.Normal)
            btn.setTitle("\(myAccountList[indexPath.row])", forState: UIControlState.Highlighted)
            btn.addTarget(self, action:"gotoUpdatePassword", forControlEvents: .TouchUpInside)
            btn.addUnderLine()
            btn.setNeedsDisplay()
            cell.addSubview(btn)
            break;
        default:
            print("")
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func gotoUpdatePassword(){
        let nv = Util().getControllerForStoryBoard("ChangePasswordTB") as! ChangePasswordTB
        self.navigationController?.pushViewController(nv, animated: true)
    }

}
