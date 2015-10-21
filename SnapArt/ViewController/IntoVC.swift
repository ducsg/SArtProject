//
//  IntoVC.swift
//  FrameBridgeLike
//
//  Created by HD on 10/3/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class IntoVC: CustomViewController,UIPageViewControllerDataSource {
    var vcArray:NSArray!
    var pageVC:UIPageViewController!
    @IBOutlet var pageIndicator: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("UIPageControl.appearance() \(UIPageControl.appearance())", terminator: "")
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.grayColor()
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.whiteColor()
        
        let logoImage:UIImage = UIImage(named: "SA_Logo")!
        let logoView:UIImageView = UIImageView(frame: CGRectMake(0, 0, logoImage.size.width, logoImage.size.height))
        logoView.image = logoImage
        print("self.navigationItem.titleView \(self.navigationItem.titleView)", terminator: "")
        self.navigationItem.titleView = logoView

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mailFrameTap(sender: AnyObject) {
        let vc:UpLoadPreviewVC = self.storyboard?.instantiateViewControllerWithIdentifier("UploadViewVC") as! UpLoadPreviewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pageVC" {
            pageVC = segue.destinationViewController as! UIPageViewController
            pageVC.dataSource = self
            
            let v1:ImageContentVC = self.storyboard?.instantiateViewControllerWithIdentifier("ImageContentVC") as! ImageContentVC
            let v2:ImageContentVC = self.storyboard?.instantiateViewControllerWithIdentifier("ImageContentVC") as! ImageContentVC
            let v3:ImageContentVC = self.storyboard?.instantiateViewControllerWithIdentifier("ImageContentVC") as! ImageContentVC
            let v4:ImageContentVC = self.storyboard?.instantiateViewControllerWithIdentifier("ImageContentVC") as! ImageContentVC

            v1.setBgImage("Home 1")
            v2.setBgImage("Home 2")
            v3.setBgImage("Home 3")
            v4.setBgImage("Home 4")

            self.vcArray =  NSArray(objects: v1,v2,v3,v4)
            pageIndicator.currentPage = 0
            let viewControllers = [v1]
            pageVC.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Reverse, animated: false, completion: nil)
            self.pageVC.didMoveToParentViewController(self)
            
        }
        
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let currentIndex:Int = self.vcArray.indexOfObject(viewController)
        self.pageIndicator.currentPage = self.pageIndicator.currentPage - 1
        

        let imageContentVC:ImageContentVC = viewController as! ImageContentVC
        var index:Int = imageContentVC.pageIndex
        
        if currentIndex > 0  {
            return self.vcArray.objectAtIndex(currentIndex-1) as? UIViewController // return the previous viewcontroller
        } else {
            return nil;// do nothing
        }

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = self.vcArray.indexOfObject(viewController)
        self.pageIndicator.currentPage = self.pageIndicator.currentPage + 1
        if ( currentIndex < (self.vcArray.count-1)){
            return self.vcArray.objectAtIndex(currentIndex+1) as? UIViewController // return the previous viewcontroller
        } else {
            return nil; // do nothing
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
