//
//  CustomPickerView.swift
//  SnapArt
//
//  Created by HD on 11/8/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

protocol CustomPickerViewDelegate {
    func selectedAt(index:Int)
}
class CustomPickerView: UIView, UIPickerViewDelegate , UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var hiddenBtn: UIButton!
    internal var delagate:CustomPickerViewDelegate!
    internal var hiddenPicker:Bool!

    private var indexSelected:Int = 0
    private var pickerData:[FrameSize]!
    
    

    
    override init(frame: CGRect = CGRectZero) {
        super.init(frame: frame)

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        self.hiddenBtn.backgroundColor = UIColor.clearColor()
        self.hiddenBtn.titleLabel?.font = SA_STYPE.FONT_GOTHAM_BOLD
        self.hiddenBtn.titleLabel?.textColor = SA_STYPE.TEXT_LABEL_COLOR
        self.backgroundColor = UIColor.whiteColor()
        self.hiddenBtn.setTitleColor(SA_STYPE.TEXT_LABEL_COLOR, forState: UIControlState.Normal)
        
    }
    func setData(data: [FrameSize]) -> Void{
        pickerData = data
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.reloadAllComponents()
        pickerView.selectedRowInComponent(0)
    }
    
    static func instanceFromNib() -> CustomPickerView {
        return UINib(nibName: "CustomPickerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CustomPickerView
    }
    
    @IBAction func hiddenTap(sender: AnyObject) {
        delagate.selectedAt(indexSelected)
        self.hiddenPicker = true
        self.hidden = hiddenPicker
    }
    
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.indexSelected = row
        return pickerData[row].frame_size
        
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
