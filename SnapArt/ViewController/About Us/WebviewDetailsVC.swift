//
//  AboutUsDetailsVC.swift
//  SnapArt
//
//  Created by HD on 10/29/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class WebviewDetailsVC: CustomViewController {
    public static var title:String = "Webview Details"
    public static var url:String = "http://snapart.strikingly.com/"

    @IBOutlet weak var btnCancel: CustomBarButtonItem!
    
    @IBOutlet weak var wvDetail: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = WebviewDetailsVC.title
        self.wvDetail.loadRequest(NSURLRequest(URL: NSURL(string: WebviewDetailsVC.url)!))
        // Do any additional setup after loading the view.
        self.applyBackIcon()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
