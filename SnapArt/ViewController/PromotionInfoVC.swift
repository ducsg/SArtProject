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
    
    @IBOutlet weak var lbEmpty: CustomLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyBackIcon()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        Util().getCountryCode { (success) -> () in
            if(success){
               self.getPromoInfor()
            }else{
               Util().showAlert(MESSAGES.COMMON.CAN_NOT_GET_LOCATION, parrent: self)
            }
        }
    }
    
    func pressBackIcon(sender: UIBarButtonItem!) -> Void{
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showPromoCodeInfor(show: Bool){
        self.lbEmpty.hidden = show
        self.lbPromoCode.hidden = !show
        self.lbDiscount.hidden = !show
        self.lbStart.hidden = !show
        self.lbEnd.hidden = !show
    }
    
    func getPromoInfor(){
        let param = ["country_code" : MemoryStoreData().getString(MemoryStoreData.user_country_code)]
        let api:Api = Api()
        let parentView:UIView! = self.navigationController?.view
        api.initWaiting(parentView)
        api.execute(ApiMethod.GET, url: ApiUrl.get_promotion, parameters: param, resulf: {(dataResult: (success: Bool, message: String, data: JSON!)) -> Void in
            if(dataResult.success){
                self.lbPromoCode.text = dataResult.data["code"].stringValue
                self.lbDiscount.text = dataResult.data["sale_off"].numberValue.stringValue + "% OFF"
                self.lbStart.text = "Start: " + Util().formatDatetime(dataResult.data["start_time"].stringValue, outputFormat: "MM/dd/yy")
                self.lbEnd.text = "End: " + Util().formatDatetime(dataResult.data["end_time"].stringValue, outputFormat: "MM/dd/yy")
                self.showPromoCodeInfor(true)
            }else{
                self.lbEmpty.text = dataResult.message
                self.showPromoCodeInfor(false)
            }
        })
    }
}
