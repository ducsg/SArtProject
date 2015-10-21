//
//  CustomTableViewController.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

public class CustomTableViewController: UITableViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func awakeFromNib() {
        applyStyle()
    }

    public func applyStyle(){
        self.tableView.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        self.tableView.backgroundView = UIView(frame: self.tableView.frame)
        self.tableView.backgroundView!.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: SA_STYPE.FONT_GOTHAM,  NSForegroundColorAttributeName: SA_STYPE.TEXT_LABEL_COLOR]
        
        let numbCell:Int = self.tableView.numberOfRowsInSection(0) as Int
        for (var index = 0; index < numbCell ; index++ ) {
            let cell:UITableViewCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))!
            cell.contentView.backgroundColor = UIColor.clearColor()
            cell.backgroundColor = UIColor.clearColor()
        }
        
        let aSelector : Selector = "closeKeyboard:"
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        view.addGestureRecognizer(tapGesture)
    }
    func closeKeyboard(sender: AnyObject) -> Void {
        self.view.endEditing(true)
    }
   
}
