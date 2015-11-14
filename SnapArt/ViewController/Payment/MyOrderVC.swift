//
//  MyOrderVC.swift
//  SnapArt
//
//  Created by HD on 11/13/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class MyOrderVC: CustomViewController , UITableViewDataSource,UITableViewDelegate  {
    @IBOutlet weak var titlesView: HeaderView!
    @IBOutlet weak var myOrderTb: UITableView!
    let TITLES = ["Preview","Date","Code","Status"]
    private var TITTLE = "My Orders"

    override func viewDidLoad() {
        super.viewDidLoad()
        applyBackIcon()
        self.title = self.TITTLE
//        let nib = UINib(nibName: "MyOrderCell", bundle: nil)
//        myOrderTb.registerNib(nib, forCellReuseIdentifier: "cell")
//
        myOrderTb.registerClass(MyOrderCell.self, forCellReuseIdentifier: "MyOrderCell")
        myOrderTb.delegate = self
        myOrderTb.dataSource = self

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
        return 4
    }
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MyOrderCell = tableView.dequeueReusableCellWithIdentifier("MyOrderCell") as! MyOrderCell
        cell.setTransaction(Transaction(image: UIImage(named: "girl-nice-hair"), date: NSDate(), code: "qe1234", status: "Placed"))
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
