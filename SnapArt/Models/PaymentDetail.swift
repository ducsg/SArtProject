//
//  PaymentDetail.swift
//  SnapArt
//
//  Created by HD on 11/6/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation

class PaymentDetail:Serializable{
    var subtotal:Float = 0
    var promo_code:String = ""
    var discount:Float = 0
    var shopping_cost:Float = 0
    var payment_amount:Float = 0
    var billing_address:Address = Address()
    var shipping_address:Address = Address()
    var list_order:[Order] = [Order]()
}