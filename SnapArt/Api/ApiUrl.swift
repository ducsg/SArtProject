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
    static let create_client_token_url:String = base_url + "api/payments/create_client_token"
    static let payment_url:String = base_url + "api/payments/pay"
    static let payment_scanner_url:String = base_url + "api/payments/pay_scanner"
    
    //social
    static let like_fb_url:String = "https://www.facebook.com/getsnapart/"
    static let follow_in_url:String = "https://instagram.com/getsnapart/"

    //About Us
    static let how_it_work_url:String = base_url + "/howitworks"
    static let faq_url:String = base_url + "/faqs"
    static let our_story_url:String = base_url + "/ourstories"
}