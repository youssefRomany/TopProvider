//
//  RoundedView.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var cornerRaduis: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRaduis
        }
    }
    override func awakeFromNib() {
        self.layer.cornerRadius = cornerRaduis
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layer.cornerRadius = cornerRaduis
        self.clipsToBounds = true
    }
}
