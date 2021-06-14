//
//  ProviderSideMenuTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/10/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class ProviderSideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
