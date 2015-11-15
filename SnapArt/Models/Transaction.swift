//
//  Transaction.swift
//  SnapArt
//
//  Created by HD on 11/13/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class Transaction: Serializable {
    var img_url: String = ""
    var created_at: String = ""
    var shipped_at: String = ""
    var order_id_full: String = ""
    var status: String = ""
    var id: Int = 0

    init(id:Int = 0 , imgUrl:String = "", created_at: String = "", shipped_at: String = "", code: String = "", status:String = "Placed"){
        self.id = id
        self.img_url = imgUrl
        self.created_at = created_at
        self.shipped_at = shipped_at
        self.order_id_full = code
        self.status = status
    }
}
