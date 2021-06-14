//
//  CoustomMassages.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import Localize_Swift
import UIKit
import SwiftMessages
import NotificationBannerSwift
func editTextError(editText:UITextField) -> UITextField {
    editText.layer.cornerRadius = editText.frame.height/2
    editText.layer.borderWidth = 1
    editText.layer.borderColor = UIColor.red.cgColor
    return editText
}

func editTextValid(editText:UITextField) -> UITextField {
    editText.layer.cornerRadius = editText.frame.height/2
    editText.layer.borderWidth = 1
    editText.layer.borderColor = UIColor.lightGray.cgColor
    return editText
}


func ShowErrorMassge(massge:String , title:String){
    let view = MessageView.viewFromNib(layout: .cardView)
    view.configureTheme(.error)
    view.configureDropShadow()
    SwiftMessages.defaultConfig.duration = .seconds(seconds: 4.5)
    view.configureContent(title:title.localized(), body: massge.localized(), iconImage: #imageLiteral(resourceName: "errorr") , iconText: "", buttonImage: nil, buttonTitle: "OK") { _ in
        SwiftMessages.hide()}
    view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
    SwiftMessages.show(view: view)
    
}


func ShowTrueMassge(massge:String , title:String){
    let view = MessageView.viewFromNib(layout: .cardView)
    view.configureTheme(.success)
    view.configureDropShadow()
    SwiftMessages.defaultConfig.duration = .seconds(seconds: 4.5)
    view.configureContent(title:title.localized(), body: massge.localized(), iconImage: #imageLiteral(resourceName: "true"), iconText: "", buttonImage:nil, buttonTitle: "OK") { _ in
        SwiftMessages.hide()}
    view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
    SwiftMessages.show(view: view)
    
}


func ShowInformationMassge(massge:String , title:String){
    let view = MessageView.viewFromNib(layout: .cardView)
    view.configureTheme(.warning)
    view.configureDropShadow()
    SwiftMessages.defaultConfig.duration = .seconds(seconds: 4.5)
    view.configureContent(title:title.localized(), body: massge.localized(), iconImage:#imageLiteral(resourceName: "logo 2"), iconText:nil, buttonImage:nil, buttonTitle: "OK") { _ in
        SwiftMessages.hide()}
    view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
    SwiftMessages.show(view: view)
    
}


func NoInterNetMassge(){
    
    let banner = StatusBarNotificationBanner(title:"No Internet..Waiting to reconnect".localized())
    //banner.subtitleLabel?.textColor = AppUtils.getObject().chatgradientColor()
    //banner.subtitleLabel?.font = UIFont(name: "JFFlat-Regular", size: 14)
    // banner.titleLabel?.textColor = AppUtils.getObject().chatgradientColor()
    banner.backgroundColor = #colorLiteral(red: 0.9667869607, green: 0.8070821271, blue: 0.2714624504, alpha: 1)
    
    banner.dismissOnSwipeUp = true
    banner.show()
    
}

func PrayNote(massge:String){
    
    let view = MessageView.viewFromNib(layout: .cardView)
    var config = SwiftMessages.Config()
    config.presentationStyle = .center
    config.duration = .forever
    
    view.configureTheme(.info)
    view.configureDropShadow()
    view.configureBackgroundView(width: 250)
    view.configureContent(title: "", body: massge , iconText:"🕌")
    view.button?.isHidden = true
    
    (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
    
    // Show the message.
    SwiftMessages.show(config: config, view: view)
    
}


func ShowNoConnectionMassge(massge:String , title:String){
    let view = MessageView.viewFromNib(layout:.statusLine)
    view.backgroundColor = UIColor.yellow
    
    var config = SwiftMessages.defaultConfig
    config.presentationStyle = .center
    config.duration = .forever
    
    
    (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
    SwiftMessages.show(view: view)
    
}
