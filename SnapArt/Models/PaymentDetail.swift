//
//  PaymentDetail.swift
//  SnapArt
//
//  Created by HD on 11/6/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation

class PaymentDetail:Serializable{
    internal var subtotal:Float = 0
    internal var promo_code:String = ""
    internal var discount:Float = 0
    internal var shopping_cost:Float = 0
    internal var payment_amount:Float = 0
    internal var billing_address:Address = Address()
    internal var shipping_address:Address = Address()
    internal var list_order:[Order] = [Order]()
    internal var payment_method_nonce:String = ""
    internal var creditCard:[String:String] = [String:String]()
    internal var payment_method: Int = 0
    
    func getObjectFromString(jsonString:String) -> PaymentDetail{
        let json:Json = Json(string:jsonString)
        let paymentDetail = PaymentDetail()
        paymentDetail.subtotal = json["subtotal"].asFloat!
        paymentDetail.promo_code = json["promo_code"].asString!
        paymentDetail.discount = json["discount"].asFloat!
        paymentDetail.shopping_cost = json["shopping_cost"].asFloat!
        paymentDetail.payment_amount = json["payment_amount"].asFloat!
        paymentDetail.payment_method_nonce = json["payment_method_nonce"].asString!
        paymentDetail.payment_method = json["payment_method"].asInt!
        
        //set shipping address
        let billingAddressData = Address()
        billingAddressData.firstName = json["billing_address"]["firstName"].asString!
        billingAddressData.lastName = json["billing_address"]["lastName"].asString!
        billingAddressData.address1 = json["billing_address"]["address1"].asString!
        billingAddressData.address2 = json["billing_address"]["address2"].asString!
        billingAddressData.city = json["billing_address"]["city"].asString!
        billingAddressData.state = json["billing_address"]["state"].asString!
        billingAddressData.country = json["billing_address"]["country"].asString!
        billingAddressData.postalCose = json["billing_address"]["postalCose"].asString!
        paymentDetail.billing_address = billingAddressData
        
        //set shipping address
        let shippingAddressData = Address()
        shippingAddressData.firstName = json["shipping_address"]["firstName"].asString!
        shippingAddressData.lastName = json["shipping_address"]["lastName"].asString!
        shippingAddressData.address1 = json["shipping_address"]["address1"].asString!
        shippingAddressData.address2 = json["shipping_address"]["address2"].asString!
        shippingAddressData.city = json["shipping_address"]["city"].asString!
        shippingAddressData.state = json["shipping_address"]["state"].asString!
        shippingAddressData.country = json["shipping_address"]["country"].asString!
        shippingAddressData.postalCose = json["shipping_address"]["postalCose"].asString!
        paymentDetail.shipping_address = shippingAddressData
        
        //set list order
        for (i, _order) in json["list_order"] {
            print(_order)
            paymentDetail.list_order.append(
                Order(id: _order["id"].asInt!, quantity: _order["quantity"].asInt! ,frameUrl: _order["frameUrl"].asString!, item: _order["item"].asString!, price: _order["price"].asFloat!, size: _order["size"].asString!)
            )
        }
        
        return paymentDetail
    }
    
}