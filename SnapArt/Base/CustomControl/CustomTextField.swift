//
//  CustomTextField.swift
//  SnapArt
//
//  Created by HD on 10/11/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
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
        self.textColor = SA_STYPE.TEXT_LABEL_COLOR
        self.font = SA_STYPE.FONT_GOTHAM
        self.backgroundColor = SA_STYPE.BACKGROUND_TF_COLOR
        self.layer.borderColor = SA_STYPE.BORDER_TEXTFIELD_COLOR.CGColor
        self.layer.borderWidth = 1;
    }

    @IBInspectable var padding_left: CGFloat {
        get {
            return 0
        }
        set (f) {
            layer.sublayerTransform = CATransform3DMakeTranslation(f, 0, 0)
        }
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 30.0, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.textRectForBounds(bounds)
    }
    
}
