//
//  Account.swift
//  SnapArt
//
//  Created by Khanh Duong on 10/12/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation

public class Account {
    public var email: String = ""
    public var pwd: String = ""
    public var stayLogined: Bool = false
    
    public var accessToken: String = ""
    public var accountId: Int = 0
    public var forgotEmail:String = ""
    
    init() {
    
    }
    
    init(emailStr:String, pwdStr:String, stayLoginedFlag:Bool){
        self.email = emailStr
        self.pwd = pwdStr
        self.stayLogined = stayLoginedFlag
    }
    
    func setAcountInfo(accessTokenStr accessTokenStr: String, accountID: Int) -> Void {
        self.accessToken = accessTokenStr
        self.accountId = accountID
    }
    
}
