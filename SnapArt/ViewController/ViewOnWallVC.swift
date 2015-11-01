//
//  ViewOnWallVC.swift
//  SnapArt
//
//  Created by HD on 11/1/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import AVFoundation

class ViewOnWallVC: UIViewController {
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var customSliderview:SliderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let devices = AVCaptureDevice.devices().filter{ $0.hasMediaType(AVMediaTypeVideo) && $0.position == AVCaptureDevicePosition.Back }
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
                cameraPreview.addGestureRecognizer(UITapGestureRecognizer(target: self, action:"saveToCamera:"))
                view.addSubview(cameraPreview)
//                viewSub.center = cameraPreview.center
                self.customSliderview = SliderView.instanceFromNib()
                self.customSliderview.frame = CGRectMake(0, 300, customSliderview.frame.size.width, customSliderview.frame.size.height)
                self.customSliderview.backgroundColor = UIColor.whiteColor()
                cameraPreview.addSubview(customSliderview)
            }
        }
        print(self.customSliderview)

        
        
    }
    func saveToCamera(sender: UITapGestureRecognizer) {
        if let videoConnection = stillImageOutput.connectionWithMediaType(AVMediaTypeVideo) {
            stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData)!, nil, nil, nil)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

