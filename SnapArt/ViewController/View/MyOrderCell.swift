//
//  MyOrderCell.swift
//  SnapArt
//
//  Created by HD on 11/13/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit

class MyOrderCell: UITableViewCell {
    
    private var imageContain:UIView!

    private var datelb:CustomLabelGotham!
    private var codelb:CustomLabelGotham!
    private var statuslb:CustomLabelGotham!
    private var imageV:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.imageContain = UIView()
        self.datelb = CustomLabelGotham()
        self.codelb = CustomLabelGotham()
        self.statuslb = CustomLabelGotham()
        self.imageV = UIImageView()
        self.imageContain.addSubview(imageV)
        self.addSubview(imageContain)
        self.addSubview(datelb)
        self.addSubview(codelb)
        self.addSubview(statuslb)
    }
    
    func setTransaction(transaction:Transaction) -> Void{
        let rect = self.bounds
        let width = rect.width/4
        self.imageContain.frame = CGRect(x:0, y: 0, width:Int(width), height: Int(rect.height))
        self.datelb.frame = CGRect(x: 1*Int(width), y: 0, width:Int(width), height: Int(rect.height))
        self.codelb.frame = CGRect(x: 2*Int(width), y: 0, width:Int(width), height: Int(rect.height))
        self.statuslb.frame = CGRect(x: 3*Int(width), y: 0, width:Int(width), height: Int(rect.height))
        let fm = CGRect(x: 15, y: 5, width: self.imageContain.bounds.width - 20, height:  self.imageContain.bounds.height  - 10)
        self.imageV.frame = fm
        self.imageV.image = UIImage(named: "")
        //image
        
        self.datelb.textAlignment = .Center
        self.datelb.text = transaction.created_at
        self.codelb.textAlignment = .Center
        self.codelb.text = "\(transaction.order_id_full)"
        self.statuslb.textAlignment = .Center
        self.statuslb.text = transaction.status
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
