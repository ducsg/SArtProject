//
//  UpLoadPreviewVC.swift
//  FrameBridgeLike
//
//  Created by HD on 10/4/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import FacebookImagePicker
import InstagramKit
import Alamofire
import AlamofireImage

class UpLoadPreviewVC: CustomViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate ,InstagramCollectionViewDelegate {
    
    @IBOutlet var upLoadImg: UIImageView!
    @IBOutlet var takePhotoBtn: UIButton!
    @IBOutlet var instagramBtn: UIButton!
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        upLoadImg.layer.borderWidth = 0.5
        upLoadImg.layer.borderColor = UIColor.grayColor().CGColor
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TAKE PHOTO
    @IBAction func takePhotoEvent(sender: AnyObject) {
        getImageFormLib()
    }
    // MARK: - CHOOSE FROM PHOTO FROM FACEBOOK
    @IBAction func choosefbEvent(sender: AnyObject) {
        let vc:FacebookLoginVC = self.storyboard?.instantiateViewControllerWithIdentifier("FacebookLoginVC") as! FacebookLoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - CHOOSE FROM PHOTO FROM INSTAGRAM
    @IBAction func instagramEvent(sender: AnyObject) {
        let vc:InstagramNC = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramNC") as! InstagramNC
        if let  collectionview = vc.viewControllers[0] as? InstagramCollectionView {
            collectionview.delegate = self
        }
        self.presentViewController(vc, animated: true, completion: nil)
    }
    func setImageFromInstagram(media media: InstagramMedia)  {
        self.setImageUploadWithURL(media.standardResolutionImageURL.URLString)
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
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let img:UIImage! = info[UIImagePickerControllerOriginalImage] as? UIImage
        let assetURL:NSURL! = info[UIImagePickerControllerReferenceURL] as? NSURL
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.setImageView(img)
    }
    // GET IMMAGE FOR LIB AND FACEBOOK
    func setImageUploadWithURL(imgURL: String!) -> Void{
        Alamofire.request(.GET, imgURL)
            .responseImage { response in
                debugPrint(response)
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                if let image = response.result.value {
                    self.setImageView(image)
                }
        }
    }
    
    func setImageView(image:UIImage!) -> Void {
        self.upLoadImg.image = image
        let vc = Util().getControllerForStoryBoard("SelectPhotoVC") as! SelectPhotoVC
        vc.imageCrop = image
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
