//
//  CropItVC.swift
//  SnapArt
//
//  Created by HD on 10/31/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON
class CropItVC: CustomViewController ,UIWebViewDelegate {

    @IBOutlet weak var cropBtn: UIButton!
    @IBOutlet weak var rotationBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cropWebView: UIWebView!
    internal var imageCrop:UIImage!
    private var TITTLE = "Crop It"
    private var ROTATE_FUNCTION = "rotateImage()"
    private var CROP_FUNCTION = "cropImage()"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITTLE
        let api:Api = Api()
        self.containerView.backgroundColor = UIColor.clearColor()
        self.cropWebView.scrollView.scrollEnabled = false
        self.cropWebView.delegate = self
//        self.callLoading(self.navigationController?.view)
//
//       api.uploadFile(imageCrop, resulf:{(dataResult: (success: Bool, message: String!, data: String!))->() in
//            let url = NSURL (string: dataResult.data)
//            let requestObj = NSURLRequest(URL: url!)
//            self.cropWebView.loadRequest(requestObj)
//
//        })
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rotationTap(sender: AnyObject) {
        self.cropWebView.stringByEvaluatingJavaScriptFromString(ROTATE_FUNCTION)
    }

    @IBAction func cropTap(sender: AnyObject) {
        
        let url = self.cropWebView.stringByEvaluatingJavaScriptFromString(CROP_FUNCTION)
        let vc = Util().getControllerForStoryBoard("PreviewVC") as! PreviewVC
        vc.previewURL = url!
        self.navigationController?.pushViewController(vc, animated: true)

    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.removeLoading(self.navigationController?.view)
    }
    func webViewDidStartLoad(webView: UIWebView) {
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        self.removeLoading(self.navigationController?.view)
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
