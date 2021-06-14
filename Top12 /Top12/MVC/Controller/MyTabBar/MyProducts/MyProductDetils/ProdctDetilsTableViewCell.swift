//
//  ProdctDetilsTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/17/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class ProdctDetilsTableViewCell: UITableViewCell {
    @IBOutlet weak var addtions: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var SRlbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
