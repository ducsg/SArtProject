//
//  PlaceOrderTitleTBCTableViewCell.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/13/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class PlaceOrderTitleTBC: UITableViewCell {
    
    
    @IBOutlet weak var lbQuanlity: CustomLabelGotham!
    
    @IBOutlet weak var lbPreview: CustomLabelGotham!
    
    @IBOutlet weak var lbItem: CustomLabelGotham!
    
    @IBOutlet weak var lbPrice: CustomLabelGotham!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        setFrameForTitleTable()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func instanceFromNib() -> PlaceOrderTitleTBC {
        return UINib(nibName: "PlaceOrderTitleTBC", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PlaceOrderTitleTBC
    }
    
    func setFrameForTitleTable(){
        let screenWidth = Util().getScreenWidth()
        //set position for quanlity label
        var rectQuanlity = lbQuanlity.frame
        rectQuanlity.origin.x = 15
        lbQuanlity.frame = rectQuanlity
        //set position for preview label
        var rectPreview = lbPreview.frame
        rectPreview.origin.x = CGFloat(screenWidth/10 * 2)
        lbPreview.frame = rectPreview
        //set item label
        var rectItem = lbItem.frame
        rectItem.origin.x = CGFloat(screenWidth/10 * 5)
        lbItem.frame = rectItem
        //set position for price
        var rectPrice = lbPrice.frame
        rectPrice.origin.x = CGFloat(screenWidth/10 * 8 + 10)
        lbPrice.frame = rectPrice
    }
    
}
