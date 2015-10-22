//
//  ApiUrl.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation
public class ApiUrl{
    static let base_url:String = "http://demo.innoria.com/snapart/"
    
    //account
    static let register_url:String = base_url + "api/accounts/create"
    static let signin_url:String = base_url + "api/accounts/login"
    static let forgot_url:String = base_url + "api/accounts/forgot_password"
    static let reset_pwd_url:String = base_url + "api/accounts/reset_password"
    static let signout_url:String = base_url + "api/accounts/logout"
    
    //payment
    static let create_client_token:String = base_url + "api/payments/create_client_token"
}