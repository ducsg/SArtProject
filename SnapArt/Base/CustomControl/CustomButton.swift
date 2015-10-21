//
//  CustomButton.swift
//  SnapArt
//
//  Created by HD on 10/11/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    private var underLineFlag:Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        setStyle()
    }
    
    func setStyle() -> Void {
        self.backgroundColor = SA_STYPE.BACKGROUND_BUTTON_COLOR
        self.titleLabel?.font = SA_STYPE.FONT_GOTHAM 
        self.titleLabel?.textColor = SA_STYPE.TEXT_LABEL_COLOR
        self.setTitleColor(SA_STYPE.TEXT_BUTTON_COLOR, forState: UIControlState.Normal)
    }
    
    override func drawRect(rect: CGRect) {
        
        if underLineFlag == false {
            return;
        }
        
        self.adjustsImageWhenHighlighted = true
        let textRect:CGRect  = self.titleLabel!.frame
        let descender:CGFloat  = self.titleLabel!.font.descender + CGFloat(2)
        let contextRef:CGContextRef  = UIGraphicsGetCurrentContext()!
        CGContextSetStrokeColorWithColor(contextRef, self.titleLabel!.textColor.CGColor)
        CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender);
        CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender);
        CGContextClosePath(contextRef);
        CGContextDrawPath(contextRef, CGPathDrawingMode.Stroke);
        
    }
    
    func addUnderLine() -> Void {
        underLineFlag = true
        self.setNeedsDisplay()
        self.backgroundColor = UIColor.clearColor()
        self.titleLabel?.font = SA_STYPE.FONT_GOTHAM
        self.titleLabel?.textColor = SA_STYPE.TEXT_LABEL_COLOR
        self.setTitleColor(SA_STYPE.TEXT_LABEL_COLOR, forState: UIControlState.Normal)
    }
    
    func setTitleText(text:String) -> Void {
        self.setTitle(text, forState: UIControlState.Normal)
        self.setTitle(text, forState: UIControlState.Highlighted)
        setStyle()
    }

    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
