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

    }
    
    struct COMMON{
        static let NOT_INTERNET = "Network not available."
        static let EMAIL_EMPTY = "Email can't be blank."
        static let EMAIL_INVALID = "Invalid email. Example: someone@company.com."
        static let LOADING = "Loading..."
    }
    
     struct REGISTER{
        static let PASS_INVALID = "Password is too short (minimum is 6 characters)."
        static let RE_PASS_EMPTY = "Re - Enter Password can't be blank."
        static let PASS_EMPTY = "Password can’t be blank."
        static let VERIFICATION_EMPTY = "Verification code should not be blank."
        static let COMPARE_PASSWORD = "Re - Enter Password and Password don’t match."
        static let NEW_PASSWORD_EMPTY = "Confirm New Password can't be blank."
        static let COMPARE_FORGOT_PASSWORD = "Confirm New Password and Password don’t match"
    }
}