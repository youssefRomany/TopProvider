//
//  MyOrdersTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var userCity: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: RoundedImage!
    @IBOutlet weak var stepImage: UIImageView!
    @IBOutlet weak var orderStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
