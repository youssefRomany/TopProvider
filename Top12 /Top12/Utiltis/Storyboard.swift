//
//  Storyboard.swift
//  Top12
//
//  Created by Sara Ashraf on 1/10/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//
import Foundation
import UIKit

public enum Storyboard: String {
    //storyBoards in APP
    case Splash
    case Authentication
    case Main
    
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        var detectLang: String!
        print("🔮\(Language.currentLanguage())")
        if Language.currentLanguage().contains("en") {
            detectLang = "Base"
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else if Language.currentLanguage().contains("ar") {
            detectLang = "ar-EG"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        let path = Bundle.main.path(forResource: detectLang , ofType: "lproj")
        let bundd = Bundle.init(path: path!)
        guard
            let vc = UIStoryboard(name: self.rawValue, bundle: bundd)
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        return vc
    }
}
