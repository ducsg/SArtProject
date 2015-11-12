//
//  PromotionInfoVC.swift
//  SnapArt
//
//  Created by Khanh Duong on 11/11/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import UIKit
import SwiftyJSON

class PromotionInfoVC: CustomViewController {
    
    @IBOutlet weak var lbPromoCode: UILabel!
    
    @IBOutlet weak var lbDiscount: UILabel!
    
    @IBOutlet weak var lbStart: UILabel!
    
    @IBOutlet weak var lbEnd: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyBackIcon()
        getPromoInfor()
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getPromoInfor(){
        let api:Api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        api.execute(ApiMethod.GET, url: ApiUrl.get_promotion, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                print(dataResult.data)
            }else{
                Util().showAlert(dataResult.message, parrent: self)
            }
        })
    }
}
