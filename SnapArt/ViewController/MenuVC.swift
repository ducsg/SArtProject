//
//  MenuVC.swift
//  FrameBridgeLike
//
//  Created by HD on 10/2/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class MenuVC: AMSlideMenuMainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panGesture.enabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func segueIdentifierForIndexPathInLeftMenu(indexPath: NSIndexPath!) -> String! {
        var identifier:String = "";
        switch (indexPath.row) {
        case 0:
            identifier = "firstRow"
        case 1:
            identifier = "secondRow"
        default:
            print("identifier", terminator: "")
        }
        return identifier
    }
    
    override func leftMenuWidth() -> CGFloat {
        return 250
    }
    
    override func configureLeftMenuButton(button: UIButton!) {
        var frame:CGRect  = button.frame
        frame = CGRectMake(0, 0, 25, 13)
        button.frame = frame;
        button.backgroundColor = UIColor.clearColor()
        button.setImage(UIImage(named: "menu_item"), forState: UIControlState.Normal)
    }
    
    override func openAnimationCurve() -> UIViewAnimationOptions {
        return UIViewAnimationOptions.CurveEaseInOut
    }
    
    override func closeAnimationCurve() -> UIViewAnimationOptions {
        return UIViewAnimationOptions.CurveEaseInOut
    }
    override func primaryMenu() -> AMPrimaryMenu {
        return AMPrimaryMenuLeft
    }
    
    override func deepnessForLeftMenu() -> Bool {
        return true
    }
    override func maxDarknessWhileRightMenu() -> CGFloat {
        return 0.5
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
