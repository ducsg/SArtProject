//
//  ShoppingCartTBC.swift
//  SnapArt
//
//  Created by HD on 10/28/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class ShoppingCartTBC: MGSwipeTableCell {

    
    @IBOutlet weak var tfQuanlity: UITextField!
    
    @IBOutlet weak var wvFrame: UIWebView!
    
    @IBOutlet weak var lbItem: CustomLabelGotham!
    
    @IBOutlet weak var lbPrice: CustomLabelGotham!
    
    @IBOutlet weak var btnPlus: UIButton!
    
    @IBOutlet weak var btnSubtract: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    internal func initCell(cart: Order = Order()){
        self.tfQuanlity.text = "\(cart.quantity)"
        self.tfQuanlity.textAlignment = .Center
        self.wvFrame.loadRequest(NSURLRequest(URL: NSURL(string: cart.frameUrl)!))
        self.lbItem.text = cart.item
        self.lbPrice.text = "$\(cart.price)"
        setFrameLayoutForCell()
    }
    
    static func instanceFromNib() -> ShoppingCartTBC {
        return UINib(nibName: "ShoppingCartTBC", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ShoppingCartTBC
    }
    
    func setFrameLayoutForCell(){
        let screenWidth = Util().getScreenWidth()
        //set position for quanlity label
        var rectQuanlity = tfQuanlity.frame
        rectQuanlity.origin.x = 20
        tfQuanlity.frame = rectQuanlity
        //set position for preview label
        var rectPreview = wvFrame.frame
        rectPreview.origin.x = CGFloat(screenWidth/10 * 2)
        wvFrame.frame = rectPreview
        //set item label
        var rectItem = lbItem.frame
        rectItem.origin.x = CGFloat(screenWidth/10 * 6)
        lbItem.frame = rectItem
        //set position for price
        var rectPrice = lbPrice.frame
        rectPrice.origin.x = CGFloat(screenWidth/10 * 8)
        lbPrice.frame = rectPrice
    }

}
