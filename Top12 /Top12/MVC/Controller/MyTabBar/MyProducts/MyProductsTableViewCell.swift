//
//  MyProductsTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class MyProductsTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: RoundedImage!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDisc: UILabel!
    @IBOutlet weak var menuEditBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.menuEditBtn.setImage(#imageLiteral(resourceName: "editmenu"), for: .normal)
    }

   
}
