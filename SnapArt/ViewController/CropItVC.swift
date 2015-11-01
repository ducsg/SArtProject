//
//  CropItVC.swift
//  SnapArt
//
//  Created by HD on 10/31/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class CropItVC: CustomViewController {

    @IBOutlet weak var cropBtn: UIButton!
    @IBOutlet weak var rotationBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    private var cropV:NLImageCropperView!
    internal var imageCrop:UIImage!
    private var TITTLE = "Crop It"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITTLE
        containerView.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        cropV = NLImageCropperView(frame: containerView.bounds)
        self.containerView.addSubview(cropV)
        self.containerView.backgroundColor = UIColor.clearColor()
        cropV.setCropRegionRect(CGRectMake(1, 1, 600, 600))
        imageCrop = UIImage(named: "girl_image")
        cropV.setImage(imageCrop)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rotationTap(sender: AnyObject) {
        if cropV != nil {
            imageCrop = imageCrop?.imageRotatedByDegrees(90, flip: false)
            cropV.setCropRegionRect(CGRectMake(1, 1, 350, 350))
            cropV.setImage(imageCrop)
        }
    }

    @IBAction func cropTap(sender: AnyObject) {
        let vc = Util().getControllerForStoryBoard("PreviewVC") as! PreviewVC
        self.navigationController?.pushViewController(vc, animated: true)

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
