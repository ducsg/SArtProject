//
//  Transaction.swift
//  SnapArt
//
//  Created by HD on 11/13/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class Transaction: Serializable {
    var img_url: String!
    var created_at: String!
    var order_id_full: String!
    var status: String!
    var id: Int!

    init(id:Int = 0 , imgUrl:String = "", date: String = "", code: String = "", status:String = "Placed"){
        self.id = id
        self.img_url = imgUrl
        self.created_at = date
        self.order_id_full = code
        self.status = status
    }
}
