//
//  LocalizeBase.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import Localize_Swift
class LocalizeBase: UIViewController {
    
    var flag1 = false
    var flag2 = false
    var flag3 = false
    var flag4 = false
    var utils = AppUtils.getObject()
    var params:Dictionary = [String:Any]()
    var dataArray = NSMutableArray()
    var CityArrayName = NSMutableArray()
    var CityArrayID = NSMutableArray()
    var CityID = ""
    
    
    class func changeLanguageToEnglish() {
        print("English")
        //  OCLoader.hide()
        Localize.setCurrentLanguage(Lang_en)
        UserDefaults.standard.set(["en-US"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        if SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(iosMinumumLocalizationMirror) {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).semanticContentAttribute = .unspecified
        }
    }
    
    
    
    class func changeLanguageToArabic() {
        print("arbic")
        // OCLoader.hide()
        Localize.setCurrentLanguage(Lang_ar)
        UserDefaults.standard.set(["ar-EG"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        if SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(iosMinumumLocalizationMirror) {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).semanticContentAttribute = .unspecified
        }
        
    }
    
    
    func gotoAppUser(){
        guard let window = UIApplication.shared.keyWindow else { return }
        var vc = UIViewController()
        vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        window.rootViewController = vc
    }
    
    
    func propertiesNames() -> [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
    
    
    
    
    func setViewBorder(view:UIView, color:CGColor)  {
        view.layer.borderColor = color
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
    }
    
    func setViewCircle(view:UIView)  {
        view.layer.cornerRadius = view.frame.width/2
    }
    
    
    
    
    
    func localizeTextAlignment() {
        for item in propertiesNames() {
            if value(forKey: item) is UILabel || value(forKey: item) is UITextField {
                if let obj = value(forKey: item) as? UILabel {
                    if(obj.textAlignment == .center){
                        return
                    }
                    if (Localize.currentLanguage() == "ar-EG") {
                        obj.textAlignment = .right
                    }
                    else{
                        obj.textAlignment = .left
                    }
                }
                
                if let obj = value(forKey: item) as? UITextField {
                    if(obj.textAlignment == .center){
                        return
                    }
                    if (Localize.currentLanguage() == "ar-EG") {
                        obj.textAlignment = .right
                    }
                    else{
                        obj.textAlignment = .left
                    }
                }
                
                
            }
        }
    }
}

