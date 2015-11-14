//
//  HeaderView.swift
//  SnapArt
//
//  Created by HD on 11/13/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//
import UIKit

class HeaderView: UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }
    override func awakeFromNib() {

    }
    
    func addTitles(titles:[String]) -> Void  {
        let rect = self.bounds
        let width = rect.width/4
        for index in 0...(titles.count - 1) {
            let lb = CustomLabelGotham(frame:CGRect(x: index*Int(width), y: 0, width:Int(width), height: Int(rect.height)))
            lb.textAlignment = .Center
            lb.text = titles[index]
            lb.setStyleForLabel()
            self.addSubview(lb)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        fatalError("init(coder:) has not been implemented")
    }
    
}