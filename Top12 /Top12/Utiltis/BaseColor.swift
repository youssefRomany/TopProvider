//
//  BaseColor.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation

import UIKit

var GreenEdara: UIColor { get { return UIColorFromRGB(rgbValue: 0x84D012)}}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
