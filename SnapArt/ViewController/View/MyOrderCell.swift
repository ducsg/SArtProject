//
//  MyOrderCell.swift
//  SnapArt
//
//  Created by HD on 11/13/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

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
        self.datelb.font = SA_STYPE.FONT_GOTHAM_13

        self.codelb = CustomLabelGotham()
        self.codelb.font = SA_STYPE.FONT_GOTHAM_13

        self.statuslb = CustomLabelGotham()
        self.statuslb.font = SA_STYPE.FONT_GOTHAM_13

        self.imageV = UIImageView()
        self.imageContain.addSubview(imageV)
        self.addSubview(imageContain)
        self.addSubview(datelb)
        self.addSubview(codelb)
        self.addSubview(statuslb)
        
        var rect = self.bounds
        rect.size.height = 100
        let width = rect.width/4
        self.datelb.frame = CGRect(x: 1*Int(width), y: 0, width:Int(width), height: Int(rect.height))
        self.codelb.frame = CGRect(x: 2*Int(width), y: 0, width:Int(width), height: Int(rect.height))
        self.statuslb.frame = CGRect(x: 3*Int(width), y: 0, width:Int(width), height: Int(rect.height))
        self.imageContain.frame = CGRect(x:5, y: 0, width:Int(width ), height: Int(rect.height))
        
        
        self.datelb.textAlignment = .Center

    }
    
    func setTransaction(transaction:Transaction) -> Void{
        self.datelb.text = transaction.created_at
        self.codelb.textAlignment = .Center
        self.codelb.text = "\(transaction.order_id_full)"
        self.statuslb.textAlignment = .Center
        self.statuslb.text = transaction.status
        
        self.imageV.sd_setImageWithURL(NSURL(string: transaction.img_url),placeholderImage: UIImage(named: "no_image"), completed: {(image:UIImage!,err:NSError!, type:SDImageCacheType, url:NSURL!) -> Void in
            
            let max:CGFloat = self.imageContain.frame.width - 20
            var width = image.size.width
            var height = image.size.height
            
            if width > height {
                height = height * max/width
                width = max
            }
            
            if width == height {
                width = max;
                height = max;
            }
            
            if width < height {
                width = width * max/height
                height = max
            }
            let fm = CGRect(x: 0, y: 0, width: width, height:   height)
            self.imageV.frame = fm
            self.imageV.center =  self.imageContain.center
        })
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
