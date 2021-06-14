//
//  NewProudctAddtionsTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/15/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class NewProudctAddtionsTableViewCell: UITableViewCell {
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var name_ar: UITextField!
    @IBOutlet weak var countTextFaild: UITextField!
   
    var addition : AddetionsModel!{
        didSet{
            countTextFaild.text = addition.price
            
            
        }
    }
    var count = 0
    var detectCount: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.counterLbl.isHidden = true
        self.countTextFaild.placeholder = "0"
        self.countTextFaild.layer.cornerRadius = 40/2
        
        self.backgroundColor = UIColor.clear
        self.name_ar.placeholder = "Special Addtion".localized()
        
        self.countTextFaild.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.countTextFaild.layer.borderWidth = 1
        
        self.countTextFaild.textAlignment = .center
    }
    
    @IBAction func plusAction(_ sender: Any) {
        self.countTextFaild.text = String(describing: Int(self.countTextFaild.text!)! + 1)
        addition.price = self.countTextFaild.text!
        print("💄\(addition.price)")
        detectCount?()
        
    }
    @IBAction func minusAction(_ sender: Any) {
        if Int(self.countTextFaild.text!)! == 0 {
            self.countTextFaild.text = "0"
        }else{
            self.countTextFaild.text = String(describing: Int(self.countTextFaild.text!)! - 1)
            
        }
        detectCount?()
        addition.price = self.countTextFaild.text!
        
        
       
    }
    
    
    //
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
