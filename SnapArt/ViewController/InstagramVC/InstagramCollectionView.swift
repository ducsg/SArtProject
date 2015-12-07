//
//  InstagramCollectionView.swift
//  SnapArt
//
//  Created by HD on 10/6/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import InstagramKit

protocol InstagramCollectionViewDelegate {
    func setImageFromInstagram(media media:InstagramMedia,vc:UIViewController!) -> Void
}

class InstagramCollectionView: IKCollectionViewController {
    var delegate:InstagramCollectionViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !self.instagramEngine!.isSessionValid() {
            let vc:BaseNC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginInstagramNC") as! BaseNC
            self.presentViewController(vc, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    @IBAction func loginTap(sender: AnyObject) {
        
        if !self.instagramEngine!.isSessionValid() {
            let vc:BaseNC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginInstagramNC") as! BaseNC
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else {
            self.instagramEngine!.logout()
            let alert:UIAlertView = UIAlertView(title: "InstagramKit", message: "You are now logged out.", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
        
    }

    @IBAction func closeTap(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let media:InstagramMedia  = self.mediaArray[indexPath.row] as! InstagramMedia
        if delegate != nil {
            delegate.setImageFromInstagram(media: media,vc:self.navigationController )
        }
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
