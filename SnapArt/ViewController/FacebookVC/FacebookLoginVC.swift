//
//  FacebookLoginVC.swift
//  SnapArt
//
//  Created by HD on 10/8/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import FBAudienceNetwork
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookImagePicker

class FacebookLoginVC:CustomViewController, FBSDKLoginButtonDelegate , OLFacebookImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var loginBtn: FBSDKLoginButton!
    @IBOutlet weak var albumbtn: CustomButton!
    @IBOutlet weak var statuslb: CustomLabel!
    @IBOutlet weak var avatarImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loginBtn = FBSDKLoginButton()
        self.loginBtn.delegate = self
        self.loginBtn.readPermissions = ["user_photos"]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeTap(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func album(sender: AnyObject) {
        let vc = OLFacebookImagePickerController()
        vc.delegate = self
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
    }
    
//    @IBAction func loginfbTap(sender: AnyObject) {
//        if FBSession.activeSession().state != FBSessionStateOpen && FBSession.activeSession().state != FBSessionStateOpenTokenExtended {
//            // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
//        }
//        else {
//            FBSession.activeSession().closeAndClearTokenInformation()
//        }
//    }
//    
//    
//    func sessionStateChanged(session : FBSession, state : FBSessionState, error : NSError)
//    {
//        // If the session was opened successfully
//        if  state == FBSessionStateOpen
//        {
//            print("Session Opened")
//        }
//    }
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil {
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    func facebookImagePicker(imagePicker: OLFacebookImagePickerController!, didFailWithError error: NSError!) {
        
    }
    func facebookImagePicker(imagePicker: OLFacebookImagePickerController!, didFinishPickingImages images: [AnyObject]!) {
        self.navigationController?.popViewControllerAnimated(true)
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    func facebookImagePickerDidCancelPickingImages(imagePicker: OLFacebookImagePickerController!) {
        
    }
    
}

