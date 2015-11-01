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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "sendTap:")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func previewOnWallTap(sender: AnyObject) {
        
    }
    func sendTap(sender: AnyObject) {
        let textToShare = "Share image Snapart"
        
        if let imageCrop = UIImage(named: "girl_image")
        {
            let objectsToShare = [textToShare, imageCrop]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    // MARK: ADD TO CARD
    @IBAction func addToCartTap(sender: AnyObject) {
        let nv = Util().getControllerForStoryBoard("ShoppingCheckoutNC") as! CustomNavigationController
        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
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
