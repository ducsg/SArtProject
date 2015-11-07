//
//  CustomTableViewController.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

public class CustomTableViewController: UITableViewController {
    internal var tapGest: UITapGestureRecognizer!
    
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
        for (var index = 0; index < numbCell - 1 ; index++ ) {
            let cell:UITableViewCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))!
            cell.contentView.backgroundColor = UIColor.clearColor()
            cell.backgroundColor = UIColor.clearColor()
        }
        
        let aSelector : Selector = "closeKeyboard:"
        tapGest = UITapGestureRecognizer(target: self, action: aSelector)
        view.addGestureRecognizer(tapGest)
    }
    
    public func applyBackIcon(){
        let backImg: UIImage = UIImage(named: "ic_back")!
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg, style: UIBarButtonItemStyle.Plain, target: self, action: "pressBackIcon:")
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor().fromHexColor("#000000")
    }
    
    func closeKeyboard(sender: AnyObject) -> Void {
        self.view.endEditing(true)
    }
   
}
