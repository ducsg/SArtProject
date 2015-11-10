//
//  NotificationTBC.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/9/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class NotificationTBC: UITableViewCell {

    @IBOutlet weak var lbTitle: CustomLabelGotham!
    
    @IBOutlet weak var lbDatetime: CustomLabelGotham!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func instanceFromNib() -> NotificationTBC {
        return UINib(nibName: "NotificationTBC", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NotificationTBC
    }
    
}
