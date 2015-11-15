//
//  DataManager.swift

/*
* [...]
* @project:  AllerPal
* @version: 1.0
* @since:   swift 2.0
* @Created: by Ngo Hoai Duc on 6/4/15 All rights reserved.
* @Developer: Ngo Hoai Duc
* @Email: ducngo@innoria.com
* @Skype: ngohoaiduc
*/

import UIKit

class DataManager {
    static let sharedInstance = DataManager()
    var user : Account = Account()
}

class OrderSubmit {
    var accessToken: String = ""
    var accountId: Int = 0
    var frame_size_id: Int = 0
    var image_id: Int = 0
}


