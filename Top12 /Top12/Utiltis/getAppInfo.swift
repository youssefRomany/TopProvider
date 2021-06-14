//
//  getAppInfo.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import Localize_Swift
func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(_ v: String) -> Bool {
    return UIDevice.current.systemVersion.compare(v, options: .numeric) != .orderedAscending
}

func getServerLang () -> String{
    if (Localize.currentLanguage() == Lang_ar){
        return "ar"
    }
    return "en"
}

func getServerLangPassion () -> String{
    if (Localize.currentLanguage() == Lang_ar){
        return "2"
    }
    return "en"
}

func getScreenWidth() -> CGFloat {
    let screenSize = UIScreen.main.bounds
    let screenWidth = screenSize.width
    return screenWidth
}

func getScreenHeight() -> CGFloat {
    let screenSize = UIScreen.main.bounds
    let screenHeight = screenSize.width
    return screenHeight
}
