//
//  BaseNC.swift
//  SnapArt
//
//  Created by HD on 10/7/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class BaseNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        applyStyle()
    }
    
    func applyStyle(){
        self.navigationBar.titleTextAttributes = [ NSFontAttributeName: SA_STYPE.FONT_GOTHAM,  NSForegroundColorAttributeName: SA_STYPE.TEXT_LABEL_COLOR]
        self.navigationBar.tintColor = SA_STYPE.BACKGROUND_BUTTON_COLOR
        let item = UIBarButtonItem(title: "", style: .Bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = item
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
