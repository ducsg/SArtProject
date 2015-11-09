//
//  PaymentDetail.swift
//  SnapArt
//
//  Created by HD on 11/6/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation

class PaymentDetail:Serializable{
    public var subtotal:Float = 0
    public var promo_code:String = ""
    public var discount:Float = 0
    public var shopping_cost:Float = 0
    public var payment_amount:Float = 0
    public var billing_address:Address = Address()
    public var shipping_address:Address = Address()
    public var list_order:[Order] = [Order]()
    public var payment_method_nonce:String = ""
    public var creditCard:[String:String] = [String:String]()
    public var payment_method: Int = 0
}