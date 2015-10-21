//
//  CustomBarButtonItem.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class CustomBarButtonItem: UIBarButtonItem {
    override func awakeFromNib() {
        self.tintColor = SA_STYPE.TEXT_LABEL_COLOR
        self.setTitleTextAttributes([ NSFontAttributeName: SA_STYPE.FONT_GOTHAM], forState: UIControlState.Normal)
    }
}
