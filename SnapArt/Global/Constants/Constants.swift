//
//  Constants.swift
//  SnapArt
//
//  Created by HD on 10/11/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation

// MARK: OPEN Social Network
struct SocialNetworkUrl {
    let scheme: String
    let page: String
    
    func openPage() {
        let schemeUrl = NSURL(string: scheme)!
        if UIApplication.sharedApplication().canOpenURL(schemeUrl) {
            UIApplication.sharedApplication().openURL(schemeUrl)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: page)!)
        }
    }
}

enum SocialNetwork {
    case Facebook, GooglePlus, Twitter, Instagram
    func url() -> SocialNetworkUrl {
        switch self {
        case .Facebook: return SocialNetworkUrl(scheme: "fb://profile/PageId", page: ApiUrl.like_fb_url)
        case .Twitter: return SocialNetworkUrl(scheme: "twitter:///user?screen_name=USERNAME", page: "https://twitter.com/USERNAME")
        case .GooglePlus: return SocialNetworkUrl(scheme: "gplus://plus.google.com/u/0/PageId", page: "https://plus.google.com/PageId")
        case .Instagram: return SocialNetworkUrl(scheme: "instagram://user?username=USERNAME", page: ApiUrl.follow_in_url)
        }
    }
    func openPage() {
        self.url().openPage()
    }
}

//MARK: STYPE FOR APP
struct SA_STYPE {
    static let FONT_ARCHER:UIFont = UIFont(name:"Archer", size: 15)!
    static let FONT_GOTHAM:UIFont = UIFont(name:"Gotham Thin", size: 15)!
    static let FONT_GOTHAM_BOLD:UIFont = UIFont(name:"Gotham Bold", size: 15)!
    static let TEXT_BUTTON_COLOR:UIColor = UIColor.whiteColor()

    static let BORDER_TEXTFIELD_COLOR:UIColor = UIColor().fromHexColor("#e1e1e1")
    static let TEXT_LABEL_COLOR:UIColor = UIColor.blackColor()
    static let BACKGROUND_BUTTON_COLOR:UIColor = UIColor.blackColor()
    static let BACKGROUND_LABEL_COLOR:UIColor = UIColor.clearColor()
    static let BACKGROUND_SCREEN_COLOR:UIColor = UIColor().fromHexColor("#f0eff5")
    static let BACKGROUND_TF_COLOR:UIColor = UIColor.whiteColor()
}

