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

    override func viewDidLoad() {
        super.viewDidLoad()
        cropView.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CropContent" {
            cropVC = segue.destinationViewController as! PECropViewController
            let img = UIImage(named: "Home 1")
            cropVC.image = img
            cropVC.delegate = self
            let width:Float  = Float(img!.size.width)
            let height:Float  = Float(img!.size.height)
            let length:Float  = fminf(width,height)
            cropVC.imageCropRect = CGRectMake(CGFloat((width - length)/2),CGFloat((height - length) / 2), CGFloat(length), CGFloat(length))
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
        let sizePicker = ActionSheetStringPicker(title: "Size", rows: ["3x4","4x4","16x16","24x24"], initialSelection: 0, doneBlock: {picker, value, index in
            return }, cancelBlock: {ActionStringCancelBlock in
                return}, origin: sender.superview)
        sizePicker.showActionSheetPicker()
    }
    
    @IBAction func cropTap(sender: AnyObject) {
        
    }
    
    @IBAction func continueTap(sender: AnyObject) {
    }
    
    func cropViewController(controller: PECropViewController!, didFinishCroppingImage croppedImage: UIImage!) {
        
    }
    func cropViewController(controller: PECropViewController!, didFinishCroppingImage croppedImage: UIImage!, transform: CGAffineTransform, cropRect: CGRect) {
        
    }
    
    func cropViewControllerDidCancel(controller: PECropViewController!) {
        
    }
    func getFBRequest() -> Void {

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
