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
    internal var imageCrop:UIImage!
    private var TITTLE = "Input Size"
    let pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TITTLE
        cropView.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        containView.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR

        self.sizeBtn.layer.borderWidth = 0.5
        self.sizeBtn.layer.borderColor = UIColor.grayColor().CGColor
        self.sizeBtn.backgroundColor = UIColor.whiteColor()
        
        self.imageView.image = imageCrop
        self.imageView.contentMode = .ScaleAspectFill

        let api:Api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        
        let parameters = [APIKEY.WIDTH:1000,APIKEY.WIDTH:1000,APIKEY.IOS_REG_ID:MemoryStoreData().getString(MemoryStoreData.user_reg_id)]
        print(parameters)
        api.execute(ApiMethod.POST, url: ApiUrl.size_frames_url, parameters: parameters as! [String : AnyObject], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                //store access token and account id
            }else{
                Util().showAlert(dataResult.message, parrent: self)
            }
        })

       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sizeTap(sender: AnyObject) {
        let customView = CustomPickerView.instanceFromNib()
         let y = self.view.frame.size.height - customView.frame.height
        let rect = CGRect(x: 0, y: y, width: view.frame.width, height: customView.frame.height)
        customView.frame = rect
        customView.delagate = self
        customView.setNeedsLayout()
        customView.setData(pickerData)
        self.view.addSubview(customView)

    }
    func selectedAt(index: Int) {
        self.setValueSizeBtn(pickerData[index])
    }
  
    @IBAction func cropTap(sender: AnyObject) {
        
    }
    
    @IBAction func continueTap(sender: AnyObject) {
        let vc = Util().getControllerForStoryBoard("CropItVC") as! CropItVC
        vc.imageCrop = imageCrop
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
