//
//  CustomViewController.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

public class CustomViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    public override func viewWillAppear(animated: Bool) {
        applyStyle()
    }
    
    public func applyStyle(){
        
        self.view.backgroundColor = SA_STYPE.BACKGROUND_SCREEN_COLOR
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: SA_STYPE.FONT_GOTHAM,  NSForegroundColorAttributeName: SA_STYPE.TEXT_LABEL_COLOR]
        self.navigationController?.navigationBar.tintColor = SA_STYPE.BACKGROUND_BUTTON_COLOR
        let item = UIBarButtonItem(title: "", style: .Bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    
}
