//
//  PreviewVC.swift
//  SnapArt
//
//  Created by HD on 10/25/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import AVFoundation

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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkoutLogin:", name:MESSAGES.NOTIFY.CHECKOUT_LOGIN, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func previewOnWallTap(sender: AnyObject) {
        
        let vc = Util().getControllerForStoryBoard("ViewOnWallVC") as! ViewOnWallVC
        createCaptureVideoPreviewLayer(vc)
        self.navigationController?.pushViewController(vc, animated: true)
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
        if(MemoryStoreData().getString(APIKEY.ACCESS_TOKEN) == ""){
            SignInVC.loginForCheckout = true
            let nv = Util().getControllerForStoryBoard("LoginNC") as! CustomNavigationController
            self.navigationController?.presentViewController(nv, animated: true, completion: nil)
        }else{
            let nv = Util().getControllerForStoryBoard("ShoppingCheckoutNC") as! CustomNavigationController
            self.navigationController?.presentViewController(nv, animated: true, completion: nil)
        }
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
    
    func createCaptureVideoPreviewLayer(controller: ViewOnWallVC) {
        let devices = AVCaptureDevice.devices().filter{ $0.hasMediaType(AVMediaTypeVideo) && $0.position == AVCaptureDevicePosition.Back }
        let captureSession = AVCaptureSession()
        let stillImageOutput = AVCaptureStillImageOutput()

        if let captureDevice = devices.first as? AVCaptureDevice  {
            captureSession.addInput(try! AVCaptureDeviceInput(device: captureDevice))
            captureSession.sessionPreset = AVCaptureSessionPresetPhoto
            captureSession.startRunning()
            stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
            if captureSession.canAddOutput(stillImageOutput) {
                captureSession.addOutput(stillImageOutput)
            }
            
            if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) {
                previewLayer.bounds = CGRectMake(0.0, 0.0, view.bounds.size.width, view.bounds.size.height)
                previewLayer.position = CGPointMake(view.bounds.midX, view.bounds.midY)
                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                let cameraPreview = UIView(frame: CGRectMake(0.0, 0.0, view.bounds.size.width, view.bounds.size.height))
                cameraPreview.layer.addSublayer(previewLayer)
                controller.view.addSubview(cameraPreview)
                controller.addViewPreview()
            }
            
        }
    }

    func checkoutLogin(sender:AnyObject){
        self.addToCartTap(self)
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
