//
//  Notification.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/9/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

class Notification{
    public var id = 0
    public var read_at = ""
    public var created_at = ""
    public var transaction_id = 0
    public var type_of_notification = 0
    public var action = 0
    public var title = ""
    
    init(id:Int = 0, read_at:String = "", created_at:String = "", transaction_id:Int = 0, type_of_notification:Int = 0, action:Int = 0, title:String = ""){
        self.id = id
        self.read_at = read_at
        self.created_at = created_at
        self.transaction_id = transaction_id
        self.type_of_notification = type_of_notification
        self.action = action
        self.title = title
    }
}
