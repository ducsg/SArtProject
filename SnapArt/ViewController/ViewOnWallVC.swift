//
//  ViewOnWallVC.swift
//  SnapArt
//
//  Created by HD on 11/1/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import AVFoundation


class ViewOnWallVC: UIViewController, TDRatingViewDelegate {
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var customSliderview:SliderView!
    var imagePreview:UIImage!
    internal var section:AVCaptureSession!
    
    private var ratio:CGFloat = 1
    
    private let TITLE = "View On Wall"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITLE
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "sendTap:")
    }
    
    deinit {
        if section != nil && section.inputs.count>0 {
            self.section.inputs
            let input: AVCaptureInput = self.section.inputs[0] as! AVCaptureInput
            self.section.removeInput(input)
            let output: AVCaptureVideoDataOutput = self.section.outputs[0] as! AVCaptureVideoDataOutput
            self.section.removeOutput(output)
            self.section.stopRunning()
        }
        print("deinit") // never gets called
    }
    
    func addViewPreview(image: UIImage) -> Void {
        self.imagePreview = image
        self.customSliderview = SliderView.instanceFromNib()
        self.customSliderview.imagePreview.image = image
        self.customSliderview.frame = self.view.bounds
        self.view.addSubview(customSliderview)
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.customSliderview != nil {
            self.customSliderview.addImagePreview(self.imagePreview)
            let rangeSlider = TDRatingView()
            rangeSlider.maximumRating = 6
            rangeSlider.minimumRating = 2
            rangeSlider.widthOfEachNo = (UInt(self.customSliderview.sliderView.frame.width) / UInt(5))
            rangeSlider.heightOfEachNo = 30
            rangeSlider.sliderHeight = 25
            rangeSlider.difference = 1
            rangeSlider.delegate = self
            rangeSlider.drawRatingControlWithX(0, y:0)
            rangeSlider.center = self.customSliderview.sliderView.center
            self.customSliderview.sliderView.addSubview(rangeSlider)
            self.customSliderview.imagePreview.contentMode = .ScaleAspectFit
            var rect = self.customSliderview.imagePreview.bounds
            self.ratio = rect.size.width/rect.size.height
            rect.size.width = 300
            rect.size.height = rect.size.width*1/ratio
            
            self.customSliderview.imagePreview.frame = rect
            self.customSliderview.imagePreview.center = CGPointMake(customSliderview.bounds.size.width / 2, customSliderview.bounds.size.height / 2 - rect.size.height/4)
            self.customSliderview.layer.shadowOffset = CGSize(width: 4, height: 4)
            self.customSliderview.layer.shadowOpacity = 1.0
            self.customSliderview.layer.shadowRadius = 3
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func selectedRating(scale: String!) {
        let range:Int = Int(scale)!
        var rect = self.customSliderview.imagePreview.bounds
        switch range {
        case 2: rect.size.width = 250
            break
        case 3: rect.size.width = 200
            break
        case 4: rect.size.width = 150
            break
        case 5: rect.size.width = 100
            break
        case 6: rect.size.width = 50
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
}

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/

