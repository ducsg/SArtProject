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
    static let change_pwd_url:String = base_url + "api/accounts/change_password"
    static let signout_url:String = base_url + "api/accounts/logout"
    
    //payment
    static let create_client_token_url:String = base_url + "api/payments/create_client_token"
    static let payment_url:String = base_url + "api/payments/pay"
    static let payment_scanner_url:String = base_url + "api/payments/pay_scanner"
    
    //social
    static let like_fb_url:String = "https://www.facebook.com/getsnapart/"
    static let follow_in_url:String = "https://instagram.com/getsnapart/"
    static let follow_pin_url:String = "https://www.pinterest.com/getsnapart/"

    //About Us
    static let how_it_work_url:String = base_url + "/howitworks"
    static let faq_url:String = base_url + "/faqs"
    static let our_story_url:String = base_url + "/ourstories"
    
    //shopping cart
    static let my_orders_url:String = base_url + "/api/orders/get_my_orders"
    static let get_message_url:String = base_url + "/api/messages/get_message"
    static let save_message_url:String = base_url + "/api/messages/update_messages"
    static let get_discount_promo_code:String = base_url + "/api/promotions/get_discount_promotion"
    static let get_promotion:String = base_url + "/api/promotions/get_promotion"
    
    // Crop Image
//    static let crop_image_url:String = base_url + "api/cropers/upload"
    static let crop_image_url:String = "http://192.168.1.158:8080/snapart/api/cropers/upload"
    
    //notification
    static let get_notification_url:String = base_url + "api/notifications/get_my_notifications"

    //crop image view
    static let size_frames_url:String = base_url + "api/config/get_frame_sizes"
    
    //get location information
    static let get_location_infor_url:String = "http://maps.googleapis.com/maps/api/geocode/json"

}