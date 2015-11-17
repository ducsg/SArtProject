//
//  SelectPhotoVC.swift
//  SnapArt
//
//  Created by HD on 10/17/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import Darwin
import Alamofire
import SwiftyJSON


class SelectPhotoVC: CustomViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate , CustomPickerViewDelegate {
    @IBOutlet weak var cropView: BaseView!
    @IBOutlet weak var sizeBtn: UIButton!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var suggestLb: CustomLabelGotham!
    internal var imageCrop:UIImage!
    private var customPickerView:CustomPickerView!
    private var hiddenPicker = true
    private var ratioValue:Float = 1
    private var framSizeValue = ""
    private var frameSizes = [FrameSize]()
    private var TITTLE = "Input Size"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITTLE
        cropView.backgroundColor =  UIColor.clearColor()// SA_STYPE.BACKGROUND_SCREEN_COLOR
        containView.backgroundColor = UIColor.clearColor()//SA_STYPE.BACKGROUND_SCREEN_COLOR
        self.customPickerView = CustomPickerView.instanceFromNib()
        self.customPickerView.alpha = 0.9
        self.customPickerView.delagate = self
        self.customPickerView.hidden = hiddenPicker
        self.customPickerView.hiddenPicker = hiddenPicker
        self.view.addSubview(customPickerView)
        self.suggestLb.hidden = true
        self.sizeBtn.layer.borderWidth = 0.5
        self.sizeBtn.layer.borderColor = UIColor.grayColor().CGColor
        self.sizeBtn.setBackgroundImage(UIImage(named: "ic_select_frame"), forState: UIControlState.Normal)
        self.sizeBtn.setBackgroundImage(UIImage(named: "ic_select_frame"), forState: UIControlState.Highlighted)        
        self.imageView.backgroundColor = UIColor.clearColor()
        self.imageView.image = imageCrop
        self.imageView.contentMode = .ScaleAspectFill
        applyBackIcon()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        let y = self.view.frame.size.height - customPickerView.frame.height - cropView.frame.height
        let rect = CGRect(x: 0, y: y, width: view.frame.width, height: customPickerView.frame.height)
        customPickerView.frame = rect
        self.customPickerView.hidden = true
        customPickerView.setNeedsLayout()
        getFrameSizes()
    }
    @IBAction func sizeTap(sender: AnyObject) {
        self.customPickerView.hidden = false
        self.customPickerView.hiddenPicker = false
        self.customPickerView.pickerView.reloadAllComponents()
    }
    func selectedAt(index: Int) {
        self.setValueSizeBtn(frameSizes[index])
    }
    
    @IBAction func cropTap(sender: AnyObject) {
        
    }
    
    @IBAction func continueTap(sender: AnyObject) {
        if self.framSizeValue.characters.count == 0 {
            Util().showAlert(MESSAGES.COMMON.FRAME_SIZE_INVALID, parrent: self)
            return
        }
        let vc = Util().getControllerForStoryBoard("CropItVC") as! CropItVC
        vc.imageCrop = imageCrop
        vc.ratio = ratioValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - FRAME SIZE
    func setValueSizeBtn(sizeValues:FrameSize) -> Void {
        self.sizeBtn.setTitle(sizeValues.frame_size, forState: .Normal)
        self.sizeBtn.setTitle(sizeValues.frame_size, forState: .Highlighted)
        self.framSizeValue = sizeValues.frame_size
        ratioValue = sizeValues.ratio
        PreviewVC.frame_size.ratio = sizeValues.ratio
        print("sizeValues.frame_size_id: \(sizeValues.frame_size_id)")
        print("ratioValue: \(ratioValue)")
        PreviewVC.frame_size = sizeValues
        PreviewVC.order.size = sizeValues.frame_size
        
    }
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func getFrameSizes(){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
            api.initWaiting(parentView)
        let width = Int((self.imageView.image?.size.width)!)
        let height = Int((self.imageView.image?.size.height)!)
        let parameters = ["width":width,"height":height, "country_code" : MemoryStoreData().getString(MemoryStoreData.user_country_code)]
        api.execute(.POST, url: ApiUrl.size_frames_url, parameters: parameters as! [String : AnyObject], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                self.frameSizes = [FrameSize]()
                if(dataResult.data.count > 0){
                    for i in 0...dataResult.data.count-1 {
                        self.frameSizes.append(FrameSize(size: dataResult.data[i]["frame_size"].stringValue , ratio: dataResult.data[i]["ratio"].floatValue,size_id:dataResult.data[i]["id"].intValue, frame_size_config: dataResult.data[i]["frame_size_config"].stringValue))
                    }
                    self.suggestLb.hidden = false
                    if self.frameSizes.last != nil {
                        self.suggestLb.text = "With your photo resolution, we recommended you print art at \(self.frameSizes.last!.frame_size) or lower for best quality "
                    }

                    self.customPickerView.setData(self.frameSizes)
                }
            }else{
                Util().showAlert(dataResult.message, parrent: self)
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
