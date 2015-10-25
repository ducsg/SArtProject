//
//  PreviewVC.swift
//  SnapArt
//
//  Created by HD on 10/25/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class PreviewVC: CustomViewController , UIWebViewDelegate {
    @IBOutlet weak var selectBtnView: UIView!
    @IBOutlet weak var webPreview: UIWebView!
    internal var previewURL = ""
    private var TITTLE = "Preview"
    private var ADD_TO_CARD = "Add to card"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITTLE
        self.webPreview.scrollView.scrollEnabled = false
        self.webPreview.backgroundColor = UIColor.whiteColor()
        self.webPreview.delegate = self
        self.webPreview.loadRequest(NSURLRequest(URL: NSURL(string: previewURL)!))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func previewOnWallTap(sender: AnyObject) {
        
    }
    // MARK: ADD TO CARD
    @IBAction func addToCartTap(sender: AnyObject) {        
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    func webViewDidStartLoad(webView: UIWebView) -> Void {
        
    }
    func webViewDidFinishLoad(webView: UIWebView) -> Void {
        
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) ->Void {
        
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
