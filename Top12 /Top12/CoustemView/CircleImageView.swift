//
//  CircleImageView.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation

import UIKit

class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
    
}
