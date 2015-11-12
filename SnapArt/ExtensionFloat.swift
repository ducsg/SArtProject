//
//  ExtensionFloat.swift
//  SnapArt
//
//  Created by HD on 11/12/15.
//  Copyright © 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation
extension Float {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return round(self * divisor) / divisor
    }
}
