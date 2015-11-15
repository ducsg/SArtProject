//
//  MenuCell.swift
//  SnapArt
//
//  Created by HD on 10/12/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var titleLb: CustomLabelGotham!
    private var  button:CustomButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLb.hidden = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    class func instanceFromNib() -> MenuCell {
        return UINib(nibName: "MenuCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! MenuCell
    }
    
    func setTextTitle(text:String) -> Void {
        titleLb.hidden = false
        titleLb.text = text
    }
    
    func hiddenTextField(flag:Bool) -> Void {
        titleLb.hidden = flag
    }
    
    func addButton(titleText:String) -> UIButton {
        titleLb.hidden = true
        var rect:CGRect = self.contentView.frame
        rect.size.width = rect.size.width - 140
        rect.size.height = rect.size.height - 10
        rect.origin.y = 20
        rect.origin.x = 20
        let button   = UIButton(type: UIButtonType.System)
        button.frame = rect
        button.backgroundColor = SA_STYPE.BACKGROUND_BUTTON_COLOR
        button.setTitle(titleText, forState: UIControlState.Normal)
        button.setTitleColor(SA_STYPE.TEXT_BUTTON_COLOR, forState: UIControlState.Normal)
        button.setTitleColor(SA_STYPE.TEXT_BUTTON_COLOR, forState: UIControlState.Highlighted)
        button.titleLabel?.font = SA_STYPE.FONT_ARCHER
        self.addSubview(button)
        return button
    }
    
}
