//
//  Cart.swift
//  SnapArt
//
//  Created by HD on 10/28/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

public class Cart{
    var quanlity: Int = 1
    var frameUrl: String = ""
    var item: String = "Canvas"
    var price: Float = 0
    
    init(quanlity: Int = 1, frameUrl: String = "", item:String = "Canvas", price: Float = 0){
        self.quanlity = quanlity
        self.frameUrl = frameUrl
        self.item = item
        self.price = price
    }
}