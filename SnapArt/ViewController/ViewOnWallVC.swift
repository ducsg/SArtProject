//
//  ViewOnWallVC.swift
//  SnapArt
//
//  Created by HD on 11/1/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON
import Alamofire


class ViewOnWallVC: CustomViewController, TDRatingViewDelegate {
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var customSliderview:SliderView!
    var rangeSlider: TDRatingView!
    var imagePreview:UIImage!
    internal var section:AVCaptureSession!
    internal var message:String = ""
    internal var unitArray:[Float]!
    private var ratio:CGFloat = 1
    private let TITLE = "Preview on Wall"
    internal var URL_IMAGE = "http://demo.innoria.com/snapart/api/cropers/get_image_cropped?id="
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITLE
        self.applyBackIcon()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "sendTap:")
    }
    
    deinit {
        if section != nil && section.inputs.count>0 {
            let input: AVCaptureInput = self.section.inputs[0] as! AVCaptureInput
            self.section.removeInput(input)
            let output: AVCaptureVideoDataOutput = self.section.outputs[0] as! AVCaptureVideoDataOutput
            self.section.removeOutput(output)
            self.section.stopRunning()
        }
        print("deinit") // never gets called
    }
    
    func addViewPreview(image: UIImage!) -> Void {
        self.imagePreview = image
        self.customSliderview = SliderView.instanceFromNib()
        self.customSliderview.imagePreview.image = image
        self.customSliderview.frame = self.view.bounds
        self.view.addSubview(customSliderview)
    }
    
    override func viewDidAppear(animated: Bool) {

        if self.customSliderview != nil {
            self.customSliderview.textlb.text = self.message
            self.customSliderview.addImagePreview(self.imagePreview)
            self.unitArray.sortInPlace { return $0 < $1}
            if rangeSlider == nil {
                rangeSlider = TDRatingView()
                rangeSlider.maximumRating = 6
                rangeSlider.minimumRating = 2
                let meterStr = "meter"
                if meterStr.rangeOfString(message) != nil{
                    rangeSlider.sliderValArray = ["0.5","1","1.5","2","2.5"]
                }else {
                    rangeSlider.sliderValArray = ["2","3","4","5","6"]
                }
                rangeSlider.widthOfEachNo = (UInt(self.customSliderview.sliderView.frame.width) / UInt(5))
                rangeSlider.heightOfEachNo = 30
                rangeSlider.sliderHeight = 25
                rangeSlider.difference = 1
                rangeSlider.delegate = self
                rangeSlider.drawRatingControlWithX(0, y:0)
                rangeSlider.center = self.customSliderview.sliderView.center
                self.customSliderview.sliderView.addSubview(rangeSlider)
            }

            self.customSliderview.imagePreview.contentMode = .ScaleAspectFit
            var rect = self.customSliderview.imagePreview.bounds
            self.ratio = rect.size.width/rect.size.height
            rect.size.width = 300
            rect.size.height = rect.size.width*1/ratio
            
            self.customSliderview.imagePreview.frame = rect
            self.customSliderview.imagePreview.center = CGPointMake(customSliderview.bounds.size.width / 2, customSliderview.bounds.size.height / 2 - rect.size.height/4)
            self.customSliderview.imagePreview.layer.shadowOffset = CGSize(width: 4, height: 4)
            self.customSliderview.imagePreview.layer.shadowOpacity = 1.0
            self.customSliderview.imagePreview.layer.shadowRadius = 3
            self.customSliderview.addToCartBtn.addTarget(self, action: "addToCart:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func selectedRating(scale: Int32) {
        var rect = self.customSliderview.imagePreview.bounds
        switch scale {
        case 0: rect.size.width = 250
            break
        case 1: rect.size.width = 200
            break
        case 2: rect.size.width = 150
            break
        case 3: rect.size.width = 100
            break
        case 4: rect.size.width = 50
            break
        default: break
        }
        
        rect.size.height = rect.size.width*1/ratio
        self.customSliderview.imagePreview.frame = rect
        self.customSliderview.imagePreview.center = CGPointMake(customSliderview.bounds.size.width / 2, customSliderview.bounds.size.height / 2 - rect.size.height/4)
    }
    func sendTap(sender: AnyObject) {
        let textToShare = "Share image Snapart"
        self.imagePreview = self.customSliderview.imagePreview.image
        if self.imagePreview != nil {
            let objectsToShare = [textToShare, self.imagePreview]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    func addToCart(sender: AnyObject) {
        let count = (self.navigationController?.viewControllers.count)! - 2
        let vc = self.navigationController?.viewControllers[count] as! PreviewVC
        self.navigationController?.popViewControllerAnimated(true)
        vc.addToCart()
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.popViewControllerAnimated(true)
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

