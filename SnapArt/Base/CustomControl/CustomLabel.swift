//
//  CustomLabel.swift
//  SnapArt
//
//  Created by HD on 10/11/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        setStyleForLabel()
    }
    
    func setStyleForLabel() -> Void {
        self.font = SA_STYPE.FONT_ARCHER
        self.textColor = SA_STYPE.TEXT_LABEL_COLOR
        self.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.numberOfLines = 0
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
