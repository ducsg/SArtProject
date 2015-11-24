//
//  UpLoadPreviewVC.swift
//  FrameBridgeLike
//
//  Created by HD on 10/4/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
//import FacebookImagePicker
import InstagramKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class UpLoadPreviewVC: CustomViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate ,InstagramCollectionViewDelegate {
    
    @IBOutlet var upLoadImg: UIImageView!
    @IBOutlet var takePhotoBtn: UIButton!
    @IBOutlet var instagramBtn: UIButton!
    var imagePicker: UIImagePickerController!
    let TITLE = "Upload to Preview"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = TITLE
        upLoadImg.layer.borderWidth = 0.5
        upLoadImg.layer.borderColor = UIColor.grayColor().CGColor
        applyBackIcon()
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TAKE PHOTO
    @IBAction func takePhotoEvent(sender: AnyObject) {
        getImageFormLib()
        //        let image = UIImage(named: "girl_image")
        //        self.setImageView(Util().imageResize(image!, sizeChange: CGSize(width: 450,height: 800)))
    }
    
    // MARK: - CHOOSE FROM PHOTO FROM FACEBOOK
    @IBAction func choosefbEvent(sender: AnyObject) {
        let vc:FacebookLoginVC = self.storyboard?.instantiateViewControllerWithIdentifier("FacebookLoginVC") as! FacebookLoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        PreviewVC.order.image_id = 0
        MemoryStoreData().setValue(MemoryStoreData.current_order_id, value: 0)
    }
    
    // MARK: - CHOOSE FROM PHOTO FROM INSTAGRAM
    @IBAction func instagramEvent(sender: AnyObject) {
        let vc:InstagramNC = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramNC") as! InstagramNC
        if let  collectionview = vc.viewControllers[0] as? InstagramCollectionView {
            collectionview.delegate = self
        }
        self.presentViewController(vc, animated: true, completion: nil)
        PreviewVC.order.image_id = 0
        MemoryStoreData().setValue(MemoryStoreData.current_order_id, value: 0)
    }
    
    func setImageFromInstagram(media media: InstagramMedia)  {
        let newURL = media.standardResolutionImageURL.URLString.stringByReplacingOccurrencesOfString("s640x640", withString: "s1080x1080", options: NSStringCompareOptions.LiteralSearch, range: nil)
        self.setImageUploadWithURL(newURL)
    }
    
    // MARK: - CHOOSE FROM PHOTO FROM LIB
    func getImageFormLib() -> Void {
        imagePicker = UIImagePickerController()
        if UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        PreviewVC.order.image_id = 0
        MemoryStoreData().setValue(MemoryStoreData.current_order_id, value: 0)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let img:UIImage! = info[UIImagePickerControllerOriginalImage] as? UIImage
        let assetURL:NSURL! = info[UIImagePickerControllerReferenceURL] as? NSURL
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.setImageView(img)
    }
    // GET IMMAGE FOR LIB AND FACEBOOK
    func setImageUploadWithURL(imgURL: String!) -> Void{
        print(imgURL)
        self.callLoading(self.navigationController?.view)
        Alamofire.request(.GET, imgURL)
            .responseImage { response in
                debugPrint(response)
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                self.removeLoading(self.navigationController?.view)
                if let image = response.result.value {
                    self.setImageView(image)
                }
        }
    }
    
    func setImageView(image:UIImage!) -> Void {
        let data = UIImagePNGRepresentation(image) //UIImagePNGRepresentation
        var imageSize = Float(data!.length)
        imageSize = imageSize/(1024*1024)
        print("image size: \(imageSize)Mb")
        if imageSize > 10 {
            Util().showAlert(MESSAGES.MAKE_ART.IMAGE_ERROR, parrent: self)
            return
        }
        
        getFrameSizes(image, resulf: {(frameSizes:[FrameSize]) -> () in
            if frameSizes.last != nil {
                let suggestMessage = "With your photo resolution, we recommended you print art at \(frameSizes.last!.frame_size) or lower for best quality "
                let vc = Util().getControllerForStoryBoard("SelectPhotoVC") as! SelectPhotoVC
                vc.imageCrop = image
                vc.suggestMessage = suggestMessage
                vc.frameSizes = frameSizes
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
    
    private func getFrameSizes(image:UIImage, resulf:([FrameSize]) ->()){
        let api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        let width =  CGImageGetWidth(image.CGImage)
        let height = CGImageGetHeight(image.CGImage)
        let parameters = ["width":width,"height":height, "country_code" : MemoryStoreData().getString(MemoryStoreData.user_country_code)]
        api.execute(.POST, url: ApiUrl.size_frames_url, parameters: parameters as! [String : AnyObject], resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                var frameSizes = [FrameSize]()
                if(dataResult.data.count > 0){
                    for i in 0...dataResult.data.count-1 {
                        frameSizes.append(FrameSize(size: dataResult.data[i]["frame_size"].stringValue , ratio: dataResult.data[i]["ratio"].floatValue,size_id:dataResult.data[i]["id"].intValue, frame_size_config: dataResult.data[i]["frame_size_config"].stringValue))
                    }
                    resulf(frameSizes)
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
