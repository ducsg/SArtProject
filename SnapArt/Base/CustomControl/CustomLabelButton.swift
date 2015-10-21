//
//  CustomLabelButton.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

public class CustomLabelButton: UIButton {

    override public func awakeFromNib() {
        setStyle()
    }
    
    func setStyle() -> Void {
        self.backgroundColor = SA_STYPE.BACKGROUND_LABEL_COLOR
        self.titleLabel?.font = SA_STYPE.FONT_ARCHER
        self.setTitleColor(SA_STYPE.TEXT_LABEL_COLOR, forState: UIControlState.Normal)
    }
    
}
