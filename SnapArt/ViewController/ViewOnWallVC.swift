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
    private let TITLE = "View On Wall"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITLE

    }
    
    func addViewPreview() -> Void {
        self.customSliderview = SliderView.instanceFromNib()
        self.customSliderview.frame = self.view.bounds
        self.view.addSubview(customSliderview)
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

