//
//  ViewDesign.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/24/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit
func viewDesign(view:UIView){
    view.layer.shadowColor = UIColor.gray.cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowOffset = CGSize.zero
    view.layer.shadowRadius = 5
}

func ButtonDesign(Btn:UIButton){
    Btn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    Btn.layer.borderWidth = 1
    Btn.layer.shadowColor = UIColor.lightGray.cgColor
    Btn.layer.shadowOffset = CGSize(width: 3, height: 3)
    Btn.layer.shadowRadius = 5
    Btn.layer.shadowOpacity = 1.0
    
}
func EditTextDesign(text:UITextField){
    text.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    text.layer.borderWidth = 1
}
