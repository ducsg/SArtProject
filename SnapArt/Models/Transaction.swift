//
//  Transaction.swift
//  SnapArt
//
//  Created by HD on 11/13/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class Transaction: Serializable {
    var image: UIImage!
    var created_at: NSDate!
    var order_id_full: String!
    var status: String!
    var id: Int!

    init(image:UIImage!, date: NSDate = NSDate(), code: String = "", status:String = "Placed"){
        self.image = image
        self.created_at = date
        self.order_id_full = code
        self.status = status
    }
}
