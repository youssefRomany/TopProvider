//
//  CoustemDesign.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit


func editTextDesign(textFaild:UITextField){
    textFaild.layer.cornerRadius = 50/2
    textFaild.layer.borderWidth = 1
    textFaild.layer.borderColor = UIColor.lightGray.cgColor
    textFaild.borderStyle = .none
    
}

func ButtonDesign(button:UIButton ,reduse:CGFloat){
    button.layer.cornerRadius = reduse/2
    button.layer.shadowColor = UIColor.lightGray.cgColor
    button.layer.shadowOffset = CGSize(width: 3, height: 3)
    button.layer.shadowRadius = 5
    button.layer.shadowOpacity = 1.0
    
    
}

