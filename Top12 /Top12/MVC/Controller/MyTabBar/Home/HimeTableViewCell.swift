//
//  HimeTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class HimeTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: RoundedImage!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var userCity: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
