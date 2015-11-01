//
//  SelectPhotoVC.swift
//  SnapArt
//
//  Created by HD on 10/17/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import Darwin
class SelectPhotoVC: CustomViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate{
    @IBOutlet weak var cropView: BaseView!
    @IBOutlet weak var sizeBtn: UIButton!
    @IBOutlet weak var cropContainView: UIView!
    
    private var cropV:NLImageCropperView!
    internal var imageCrop:UIImage!
    private var TITTLE = "Input Size"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITTLE
        cropView.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        self.sizeBtn.layer.borderWidth = 0.5
        self.sizeBtn.layer.borderColor = UIColor.grayColor().CGColor
        self.sizeBtn.backgroundColor = UIColor.whiteColor()
        cropV = NLImageCropperView(frame: cropContainView.bounds)
        self.cropContainView.addSubview(cropV)
        self.cropContainView.backgroundColor = UIColor.clearColor()
        cropV.setCropRegionRect(CGRectMake(1, 1, 600, 600))
        imageCrop = UIImage(named: "girl_image")
        cropV.setHiddenCropView(true)
        cropV.setImage(imageCrop)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sizeTap(sender: AnyObject) {
//        let cropSizes = ["3 x 2", "3 x 5", "4 x 3", "4 x 6"," 5 x 7"," 8 x 10", "16 x 9"]
//        let sizePicker = ActionSheetStringPicker(title: "Size", rows: cropSizes, initialSelection: 0, doneBlock: {picker, value, index in
//            let selectIndex = value as! Int
//            self.setValueSizeBtn(cropSizes[selectIndex])
//            self.cropVC.cropedImageSizeWithRatio(1, and: 1)
//
//            return }, cancelBlock: {ActionStringCancelBlock in
//                return}, origin: sender.superview)
//        sizePicker.showActionSheetPicker()
    }
    
    @IBAction func cropTap(sender: AnyObject) {

    }
    
    @IBAction func continueTap(sender: AnyObject) {
        let vc = Util().getControllerForStoryBoard("CropItVC") as! CropItVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func setValueSizeBtn(sizeValues:String) -> Void {
        self.sizeBtn.setTitle(sizeValues, forState: .Normal)
        self.sizeBtn.setTitle(sizeValues, forState: .Highlighted)
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
