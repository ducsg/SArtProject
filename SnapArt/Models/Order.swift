//
//  Cart.swift
//  SnapArt
//
//  Created by HD on 10/28/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

public class Order:Serializable{
    var id: Int = 0
    var quantity: Int = 1
    var frameUrl: String = ""
    var item: String = ""
    var size: String = ""
    var price: Float = 0
    var max_quantity: Int = 1
    internal var image_id:Int = 0

    
    init(id: Int = 0, quantity: Int = 1, frameUrl: String = "", item:String = "Canvas", price: Float = 0, size: String = "", frame_size_config: String = "", max_quantity: Int = 1){
        self.id = id
        self.quantity = quantity
        self.frameUrl = frameUrl
        self.item = item
        self.price = price
        self.size = size
        self.max_quantity = max_quantity
    }
}