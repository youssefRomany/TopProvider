//
//  imageCollectionViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/15/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class imageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var deleteImage: UIButton!
    var toogleAction : (()->())?
    @IBAction func playAction(_ sender: Any) {
        toogleAction?()
    }
}
