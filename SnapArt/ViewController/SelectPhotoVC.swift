//
//  SelectPhotoVC.swift
//  SnapArt
//
//  Created by HD on 10/17/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import Darwin
class SelectPhotoVC: CustomViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, PECropViewControllerDelegate {
    @IBOutlet weak var cropView: BaseView!
    @IBOutlet weak var cropBtn: UIButton!
    @IBOutlet weak var sizeBtn: UIButton!
    @IBOutlet weak var rotationBtn: UIButton!
    private var cropVC:PECropViewController!
    private var rotationIndex:Int = 0
    internal var imageCrop:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cropView.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        self.sizeBtn.layer.borderWidth = 0.5
        self.sizeBtn.layer.borderColor = UIColor.grayColor().CGColor
        self.sizeBtn.backgroundColor = UIColor.whiteColor()
        self.setCropContentWithImage(imageCrop)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CropContent" {
            cropVC = segue.destinationViewController as! PECropViewController
           
        }
    }
    func setCropContentWithImage(image: UIImage!) -> Void {
        if self.imageCrop != nil {
            cropVC.image = self.imageCrop
            cropVC.delegate = self
            let width:Float  = Float(self.imageCrop!.size.width)
            let height:Float  = Float(self.imageCrop!.size.height)
//            let length:Float  = height + width  //fminf(width,height)
//            cropVC.imageCropRect = CGRectMake(CGFloat((width - length)/2),CGFloat((height - length) / 2), CGFloat(length), CGFloat(length))
//            cropVC.imageCropRect = CGRectMake(CGFloat((width - length)/2),CGFloat((height - length) / 2), CGFloat(length), CGFloat(length))


        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: - DELEGATE CROP VIEW CONTROLLER
    @IBAction func rotationTap(sender: AnyObject) {
        if cropVC != nil {
            rotationIndex++
            var rotationAngle:CGFloat = 0
            switch rotationIndex {
            case 1 :
                rotationAngle = 90
            case 2 :
                rotationAngle = 135
            case 3 :
                rotationAngle = 180
            default:
                rotationAngle = 0
                rotationIndex = 0
            }
            cropVC.getCropView().setRotationAngle(rotationAngle, snap: true)
            
        }
    }
    
    @IBAction func sizeTap(sender: AnyObject) {
        let cropSizes = ["3 x 2", "3 x 5", "4 x 3", "4 x 6"," 5 x 7"," 8 x 10", "16 x 9"]
        let sizePicker = ActionSheetStringPicker(title: "Size", rows: cropSizes, initialSelection: 0, doneBlock: {picker, value, index in
            let selectIndex = value as! Int
            self.setValueSizeBtn(cropSizes[selectIndex])
            self.cropVC.cropedImageSizeWithRatio(1, and: 1)

            return }, cancelBlock: {ActionStringCancelBlock in
                return}, origin: sender.superview)
        sizePicker.showActionSheetPicker()
    }
    
    @IBAction func cropTap(sender: AnyObject) {
        if self.cropVC != nil {
            cropVC.croped()
        }
    }
    
    @IBAction func continueTap(sender: AnyObject) {
        let vc = Util().getControllerForStoryBoard("PreviewVC") as! PreviewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func cropViewController(controller: PECropViewController!, didFinishCroppingImage croppedImage: UIImage!) {
        
    }
    func cropViewController(controller: PECropViewController!, didFinishCroppingImage croppedImage: UIImage!, transform: CGAffineTransform, cropRect: CGRect) {
        
    }
    
    func cropViewControllerDidCancel(controller: PECropViewController!) {
        
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
