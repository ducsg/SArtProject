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
    internal var ratio:Float = 0
    
    private var TITTLE = "Crop It"
    private var ROTATE_FUNCTION = "rotateImage()"
    private var CROP_FUNCTION = "cropImage()"
    static var current_url = NSURL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITTLE
        let api:Api = Api()
        self.containerView.backgroundColor = UIColor.clearColor()
        self.cropWebView.scrollView.scrollEnabled = false
        self.cropWebView.delegate = self
        self.applyBackIcon()
        self.callLoading(self.navigationController?.view)
        
        api.uploadFile(imageCrop,ratio:self.ratio, resulf:{(dataResult: (success: Bool, message: String!, data: String!))->() in
            if dataResult.success == true {
                let url = NSURL (string: dataResult.data)
                print(url)
                let requestObj = NSURLRequest(URL: url!)
                self.cropWebView.loadRequest(requestObj)
            } else {
                Util().showAlert(dataResult.message, parrent: self)
                self.removeLoading(self.navigationController?.view)
            }
        })
        
    }
    
    func loadCropImage(){
        let requestObj = NSURLRequest(URL: CropItVC.current_url)
        self.cropWebView.loadRequest(requestObj)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rotationTap(sender: AnyObject) {
        self.cropWebView.stringByEvaluatingJavaScriptFromString(ROTATE_FUNCTION)
    }
    
    @IBAction func cropTap(sender: AnyObject) {
        let json = self.cropWebView.stringByEvaluatingJavaScriptFromString(CROP_FUNCTION)
        if  let dic = Util().convertStringToDictionary(json!) {
            let vc = Util().getControllerForStoryBoard("PreviewVC") as! PreviewVC
            if let url = dic["url_detail"]  as? String {
                vc.previewURL = url
            }
            if let id = dic["id"]  as? Int {
                PreviewVC.order.image_id = id
            }
            print("picture_id: \(PreviewVC.order.image_id), url to crop: \(vc.previewURL)")
            self.callLoading(self.navigationController?.view)
            self.checkCroped(vc)
            
        } else {
            Util().showAlert(MESSAGES.COMMON.NOT_INTERNET, parrent: self)
        }
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.removeLoading(self.navigationController?.view)
    }
    func webViewDidStartLoad(webView: UIWebView) {
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        self.removeLoading(self.navigationController?.view)
    }
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.popViewControllerAnimated(true)
    }
    func checkCroped(vc:PreviewVC) -> Void {
        let api:Api = Api()
        api.execute(.POST, url: ApiUrl.check_image_cropped, parameters: ["id":PreviewVC.order.image_id], resulf: { (flag:Bool, message:String, json:JSON!) -> () in
            if json.boolValue == true{
                self.removeLoading(self.navigationController?.view)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            } else {
                self.checkCroped(vc)
            }
        })
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
