//
//  SliderView.swift
//  SnapArt
//
//  Created by HD on 11/1/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class SliderView: UIView  {
    @IBOutlet weak var textlb: UILabel!
    @IBOutlet weak var addToCartBtn: CustomButton!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var imagePreview: UIImageView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    static func instanceFromNib() -> SliderView {
        return UINib(nibName: "SliderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! SliderView
    }
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
        imagePreview.hidden = true
    }
    
    func addImagePreview(image:UIImage) -> Void {
        imagePreview.hidden = false
        self.imagePreview.image = image
    }
    
}

