//
//  Constants.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit
let defaults = UserDefaults.standard
let Lang_ar = "ar-EG"
let Lang_en = "en"
let textFiledWidth = ((UIScreen.main.bounds.width)/1.2)
let iosMinumumLocalizationMirror  = "10"
let User_Lat  = "User_Lat"
let User_Lng  = "User_Lng"
let User_ID  = "User_ID"
let Token_ID  = "Token_ID"
let User_Avatar  = "User_Avatar"
let User_Name  = "User_Name"
let Mobile_Number  = "Mobile_Number"
let User_Address  = "User_Address"
let orderDetilsFrom  = "orderDetilsFrom"
let is_Delgate  = "is_Delgate"
let is_Vistor  = "is_Vistor"
let is_LoogedIn  = "is_LoogedIn"
let globalConvirstionId  = "globalConvirstionId"
let convirsationFrom  = "convirsationFrom"
let UpdateProfileFrom = "UpdateProfileFrom"
let User_Email = "User_Email"
let User_Phone = "User_Phone"
let User_CityName = "User_CityName"
let User_CityID = "User_CityID"
let User_CivilNumber = "User_CivilNumber"
let User_NationaltyName = "User_NationaltyName"
let User_NationaltyID = "User_NationaltyID"
let LoggedNow = "LoggedNow"
let RegisterAs = "RegisterAs"
let UpdateOrAdd = "UpdateOrAdd"
let IS_Family = "IS_Family"
let VrefFrom = "VrefFrom"
let TermsFrom = "TermsFrom"
let SHOP_ID = "SHOP_ID"
let SHOP_NAME = "SHOP_NAME"

func getShopId() -> String{
    
    return  String(UserDefaults.standard.string(forKey: SHOP_ID) ?? "")
}

func getShopName() -> String{
    
    return  String(UserDefaults.standard.string(forKey: SHOP_NAME) ?? "")
}

func getTermsFrom() -> String{
    
    return  String(UserDefaults.standard.string(forKey: TermsFrom)!)
}


func getglobalConvirstionId() -> String{
    
    return  String(UserDefaults.standard.string(forKey: globalConvirstionId)!)
}

func getVrefFrom() -> String{
    
    return  String(UserDefaults.standard.string(forKey: VrefFrom)!)
}
func getconvirsationFrom() -> String{
    
    return  String(UserDefaults.standard.string(forKey: convirsationFrom)!)
}

func getisLoogedIn() -> String{
    
    return  String(UserDefaults.standard.string(forKey: is_LoogedIn)!)
}

func getisDelgate() -> String{
    return  String(UserDefaults.standard.string(forKey: is_Delgate)!)
}

func getoIsVistor() -> String{
    
    return  String(UserDefaults.standard.string(forKey: is_Vistor)!)
}
func getorderDetilsFrom() -> String{
    
    return  String(UserDefaults.standard.string(forKey: orderDetilsFrom)!)
}
func getUserAddress() -> String{
    
    return  String(UserDefaults.standard.string(forKey: User_Address)!)
}
func getUserLat() -> String{
    
    return  String(UserDefaults.standard.string(forKey: User_Lat)!)
}
func getUserLong() -> String{
    
    return  String(UserDefaults.standard.string(forKey: User_Lng)!)
}

func getUserID() -> String{
    
    return  UserDefaults.standard.string(forKey: User_ID)!
}
func getTokenId() -> String{
    
    return  String(UserDefaults.standard.string(forKey: Token_ID)!)
}
func getUserAvatar() -> String{
    
    return  String(UserDefaults.standard.string(forKey: User_Avatar) ?? "sideMenubg")
}
func getUserName() -> String{
    
    return  String(UserDefaults.standard.string(forKey: User_Name)!)
}
func getMobileNumber() -> String{
    
    return  String(UserDefaults.standard.string(forKey: Mobile_Number)!)
}
