//
//  ShoppingCartTBC.swift
//  SnapArt
//
//  Created by HD on 10/28/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class ShoppingCartTBC: UITableViewCell {

    
    @IBOutlet weak var tfQuanlity: UITextField!
    
    @IBOutlet weak var wvFrame: UIWebView!
    
    @IBOutlet weak var lbItem: CustomLabelGotham!
    
    @IBOutlet weak var lbPrice: CustomLabelGotham!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func initCell(cart: Cart = Cart()){
        self.wvFrame.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.islamic-literatures.com/wp-content/uploads/2013/06/grande-image3.png")!))
        self.lbItem.text = cart.item
        self.lbPrice.text = String(cart.price)
    }
    
    static func instanceFromNib() -> ShoppingCartTBC {
        return UINib(nibName: "ShoppingCartTBC", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ShoppingCartTBC
    }

}
