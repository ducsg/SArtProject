//
//  PlaceOrderTransactionTBC.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/15/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class PlaceOrderTransactionTBC: UITableViewCell {

    @IBOutlet weak var lbTransactionId: CustomLabelGotham!
    
    @IBOutlet weak var lbPlacedDate: CustomLabelGotham!
    
    @IBOutlet weak var lbShippedDate: CustomLabelGotham!
    
    @IBOutlet weak var btnStatus: CustomButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func instanceFromNib() -> PlaceOrderTransactionTBC {
        return UINib(nibName: "PlaceOrderTransactionTBC", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PlaceOrderTransactionTBC
    }
    
}
