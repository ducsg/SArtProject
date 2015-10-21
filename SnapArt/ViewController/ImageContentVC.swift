//
//  ImageContentVC.swift
//  FrameBridgeLike
//
//  Created by HD on 10/3/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class ImageContentVC: UIViewController {
    @IBOutlet var backgroundImage: UIImageView!
    var imageContent:UIImage!
    var pageIndex:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = imageContent

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBgImage(imageName:String) -> Void {
        imageContent = UIImage(named: imageName)
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
