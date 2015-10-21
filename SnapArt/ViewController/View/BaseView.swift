//
//  BaseView.swift
//  SnapArt
//
//  Created by HD on 10/8/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    //     Only override drawRect: if you perform custom drawing.
    //     An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context:CGContextRef  = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextFillRect(context, rect);
        CGContextSetStrokeColorWithColor(context, UIColor.grayColor().CGColor)

        CGContextSetLineWidth(context, 1.5)
        CGContextMoveToPoint(context, 0.0, 0.0)
        
        CGContextAddLineToPoint(context, self.frame.size.width , 0);
        CGContextStrokePath(context);
    }
    
}
