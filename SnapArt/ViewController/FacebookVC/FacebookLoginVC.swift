//
//  FacebookLoginVC.swift
//  SnapArt
//
//  Created by HD on 10/8/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
//import FBAudienceNetwork
//import FBSDKCoreKit
import FBSDKLoginKit
import FacebookImagePicker
import Alamofire
import AlamofireImage


class FacebookLoginVC:CustomViewController, FBSDKLoginButtonDelegate , OLFacebookImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var albumbtn: CustomButton!
    @IBOutlet weak var statuslb: CustomLabel!
    @IBOutlet weak var avatarImage: UIImageView!
    private var TITLE = "Log In to Facebook"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = TITLE
        applyBackIcon()
        self.albumbtn.hidden = true
        let loginfbBtn = FBSDKLoginButton()
        loginfbBtn.frame = CGRectMake(0, 0, loginBtn.frame.size.width, loginBtn.frame.size.height)
        self.loginBtn.addSubview(loginfbBtn)
        
        avatarImage.layer.borderWidth = 0.5
        avatarImage.layer.borderColor = UIColor.grayColor().CGColor
        
        loginfbBtn.delegate = self
        loginfbBtn.backgroundColor = UIColor.clearColor()
        loginfbBtn.readPermissions = ["user_photos"]
        albumbtn.clipsToBounds = true
        albumbtn.layer.cornerRadius = 3.0
        albumbtn.backgroundColor = UIColor(red: 0.231, green: 0.349, blue: 0.596, alpha: 1)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        returnUserData()
    }
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // accessToken is your Facebook id
    func returnUserProfileImage(accessToken: NSString)
    {
        let userID = accessToken as NSString
        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
        if let data = NSData(contentsOfURL: facebookProfileUrl!) {
            avatarImage.image = UIImage(data: data)
        }
    }
    func returnUserData()
    {
        callLoading(self.navigationController?.view)
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            self.removeLoading(self.navigationController?.view)
            if ((error) != nil)
            {
                // Process error
                self.albumbtn.hidden = true
                print("Error: \(error)")
            }
            else
            {
                self.albumbtn.hidden = false
                print("fetched user: \(result)")
                if let name: String = result.valueForKey("name") as? String {
                    self.statuslb.text = name
                } else {
                    print("ID es null")
                }
                
                if let id: String = result.valueForKey("id") as? String {
                    print("ID is: \(id)")
                    self.returnUserProfileImage(id)
                } else {
                    print("ID es null")
                    self.albumbtn.hidden = true
                    self.statuslb.text = "Login with facebook"
                    self.avatarImage.image = UIImage(named: "no_avatar")
                }
                
                
            }
        })
    }
    @IBAction func closeTap(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func album(sender: AnyObject) {
        let vc = OLFacebookImagePickerController()
        vc.delegate = self
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil {
        }else{
            
        }
        returnUserData()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        returnUserData()
        self.albumbtn.hidden = true
        self.statuslb.text = "Login with facebook"
        self.avatarImage.image = UIImage(named: "no_avatar")
    }
    func facebookImagePicker(imagePicker: OLFacebookImagePickerController!, didFailWithError error: NSError!) {
        
    }
    func facebookImagePicker(imagePicker: OLFacebookImagePickerController!, didSelectImage image: OLFacebookImage!) {
        if let nv = self.navigationController?.viewControllers {
            if let index:Int! = nv.count - 2 {
                if let vc = nv[index] as? UpLoadPreviewVC{
                    if let OLFacebookImg:OLFacebookImage! = image {
                        print(OLFacebookImg?.sourceImages)
                        if let array = OLFacebookImg?.sourceImages as? [OLFacebookImageURL] {
                            if array.count > 0 {
                                vc.setImageUploadWithURL(array[0].url.URLString,vc: imagePicker)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func facebookImagePicker(imagePicker: OLFacebookImagePickerController!, didFinishPickingImages images: [AnyObject]!) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func facebookImagePickerDidCancelPickingImages(imagePicker: OLFacebookImagePickerController!) {
    }
    
}

