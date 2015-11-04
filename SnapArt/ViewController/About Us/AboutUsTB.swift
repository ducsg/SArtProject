//
//  AboutUsVC.swift
//  SnapArt
//
//  Created by HD on 10/27/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class AboutUsTB: CustomTableViewController{

    @IBOutlet weak var btnCancel: CustomBarButtonItem!
    private var aboutList = ["Our Story","How It Works","Like Us","Follow us","Follow Pinterest","Rate Us"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = true
        // Do any additional setup after loading the view.
        self.applyBackIcon()
       
        self.tableView.reloadData()
    
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.tapGest != nil {
            self.tapGest.enabled = false
        }
    }
    @IBAction func pressCancelButton(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return aboutList.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AboutUsCell", forIndexPath: indexPath)
        cell.textLabel
        cell.textLabel!.font = SA_STYPE.FONT_GOTHAM
        cell.textLabel!.textColor = SA_STYPE.TEXT_LABEL_COLOR
        cell.textLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.text = aboutList[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row{
        case 0: //Our story
            WebviewDetailsVC.title = "Our Story"
            WebviewDetailsVC.url = ApiUrl.our_story_url
            goToDetail()
            break
        case 1: //How it works
            WebviewDetailsVC.title = "How It Works"
            WebviewDetailsVC.url = ApiUrl.how_it_work_url
            goToDetail()
            break
        case 2: //Like us
            SocialNetwork.Facebook.openPage()
            break
        case 3: //Follow us
            SocialNetwork.Instagram.openPage()
            break
        case 4: //Follow Pinterest us
            SocialNetwork.Pinterest.openPage()
            break
        case 5: //Rate us
            
            break
        default: break
        }
    }
    
    private func goToDetail(){
        let nv = Util().getControllerForStoryBoard("WebviewDetailsNC") as! CustomNavigationController
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }

}
