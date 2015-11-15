//
//  PlaceOrderTBC.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/7/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class PlaceOrderTBC: UITableViewCell {
    @IBOutlet weak var lbAdressTitle: CustomLabelGotham!
    @IBOutlet weak var lbFullname: CustomLabelGotham!
    @IBOutlet weak var lbAddress1: CustomLabelGotham!
    @IBOutlet weak var lbAddress2: CustomLabelGotham!
    @IBOutlet weak var lbCityState: CustomLabelGotham!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func instanceFromNib() -> PlaceOrderTBC {
        return UINib(nibName: "PlaceOrderTBC", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PlaceOrderTBC
    }
    
}
