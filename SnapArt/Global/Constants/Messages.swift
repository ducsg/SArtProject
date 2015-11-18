//
//  Messages.swift
//  SnapArt
//
//  Created by HD on 10/14/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation

struct MESSAGES{
    static let SA_ALERT_TIL = "Snap Art"
    
    struct NOTIFY {
        static let LOGIN_SUCCESS = "LoginSuccess"
        static let REMOVE_LAUNCH_SCREEN = "LaunchScreen"
        static let RESET_COST = "ResetCost"
        static let CHECKOUT_LOGIN = "CheckoutLogin"
        static let COMEBACKHOME = "ComeBackHomeVC"
        static let CHECK_ORDER = "CheckNumberOfOrder"
        
    }
    
    struct COMMON{
        static let NOT_INTERNET = "Unable to connect to the internet please try again later."
        static let API_EXCEPTION = "Error. Please try again."
        static let EMAIL_EMPTY = "Email can't be blank."
        static let EMAIL_INVALID = "Invalid email. Example: someone@company.com."
        static let FRAME_SIZE_INVALID = "Please choose frame size."

        static let LOADING = "Loading..."
        static let ORDER_EXISTED = "A previously saved order was found, do you want to continue with it?"
    }
    
     struct REGISTER{
        static let PASS_INVALID = "Password is too short (minimum is 6 characters)."
        static let OLD_PASS_EMPTY = "Old Password can't be blank."
        static let RE_PASS_EMPTY = "Re - Enter Password can't be blank."
        static let PASS_EMPTY = "Password can’t be blank."
        static let VERIFICATION_EMPTY = "Verification code should not be blank."
        static let COMPARE_PASSWORD = "Re - Enter Password and Password don’t match."
        static let NEW_PASSWORD_EMPTY = "Confirm New Password can't be blank."
        static let COMPARE_FORGOT_PASSWORD = "Confirm New Password and Password don’t match"
    }
    
    struct SHOPPING {
        static let SHOPPING_QUESTION = "For an extra $0.99, your art is wrapped in high - quality gift wrap before being securely packaged for delivery."
    }
}