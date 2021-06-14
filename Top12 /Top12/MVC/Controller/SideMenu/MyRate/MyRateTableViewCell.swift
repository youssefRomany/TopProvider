//
//  MyRateTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 4/4/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import HCSStarRatingView
class MyRateTableViewCell: UITableViewCell {
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserComment: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var rateBar: HCSStarRatingView!
    @IBOutlet weak var UserImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
