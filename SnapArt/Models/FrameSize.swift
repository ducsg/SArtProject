//
//  FrameSize.swift
//  SnapArt
//
//  Created by HD on 11/17/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

class FrameSize: NSObject {
    var frame_size = ""
    var ratio:Float = 0
    var frame_size_id:Int = 0
    var frame_size_config: String = ""
    
    override init(){
        
    }
    
    init(size:String,ratio:Float,size_id: Int = 0, frame_size_config: String = "") {
        self.frame_size = size
        self.ratio = ratio
        self.frame_size_id = size_id
        self.frame_size_config = frame_size_config
    }
    
}
