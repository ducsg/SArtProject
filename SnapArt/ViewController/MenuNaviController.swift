//
//  MenuNaviController.swift
//  SnapArt
//
//  Created by HD on 10/26/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class MenuNaviController: CustomNavigationController {
    private var launchView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageV =  UIImageView(image: UIImage(named: "first_screen"))
        launchView = UIView(frame: self.view.frame)
        launchView.backgroundColor = UIColor.clearColor()
        launchView.addSubview(imageV)
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        indicator.center = view.center
        launchView.addSubview(indicator)
        indicator.startAnimating()
        self.view.addSubview(launchView)

        let timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "receivedNotification:", userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func receivedNotification(sender:AnyObject) -> Void  {
        if launchView != nil  {
            launchView.removeFromSuperview()
        }
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
