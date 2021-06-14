//
//  EditProductTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/17/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class EditProductTableViewCell: UITableViewCell {
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var name_ar: UITextField!
    @IBOutlet weak var countTextFaild: UITextField!
    @IBOutlet weak var minsBtn: UIButton!
    @IBOutlet weak var srLbl: UILabel!
    
    
    
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
        self.srLbl.text = "SR".localized()
        self.backgroundColor = UIColor.clear
        self.name_ar.placeholder = "Special Additions".localized()
       
        self.countTextFaild.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.countTextFaild.layer.borderWidth = 1
        
        self.countTextFaild.textAlignment = .center
        self.minsBtn.setImage(UIImage(named: "cancel-1"), for: .normal)
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
