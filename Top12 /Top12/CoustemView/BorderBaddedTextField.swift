//
//  BorderBaddedTextField.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class BorderBaddedTextField: UITextField {
    
    private var padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    
    
    
    @IBInspectable var cornerRaduis: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRaduis
        }
    }
    
    @IBInspectable var borderColor2: UIColor = UIColor.blue{
        didSet {
            self.layer.borderColor = borderColor2.cgColor
        }
    }
    
    @IBInspectable var placeHolderText: String = ""{
        didSet {
            self.placeholder = placeHolderText
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                            attributes: [NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    override func awakeFromNib() {
        setView()
    }
    
    func setView() {
        self.layer.cornerRadius = cornerRaduis
        self.clipsToBounds = true
        self.placeholder = placeHolderText
        self.layer.borderColor = borderColor?.cgColor
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setView()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
