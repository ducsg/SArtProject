//
//  InstagramLoginVC.swift
//  SnapArt
//
//  Created by HD on 10/7/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class InstagramLoginVC: IKLoginViewController, UIWebViewDelegate  {
    @IBOutlet var webViewLogin: UIWebView!
    @IBOutlet var cancelBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingLoginWebView(webViewLogin)
        webViewLogin.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelTap(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
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
