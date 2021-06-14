//
//  File.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BorderView: UIView {
    
    @IBInspectable var cornerRaduis: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRaduis
            self.layer.borderWidth = 1.0
            self.layer.borderColor = borderColor2.cgColor
        }
    }
    
    @IBInspectable var borderColor2: UIColor = UIColor.gray {
        didSet {
            self.layer.borderColor = borderColor2.cgColor
        }
    }
    override func awakeFromNib() {
        self.layer.cornerRadius = cornerRaduis
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColor2.cgColor
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layer.cornerRadius = cornerRaduis
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColor2.cgColor
    }
    
}
