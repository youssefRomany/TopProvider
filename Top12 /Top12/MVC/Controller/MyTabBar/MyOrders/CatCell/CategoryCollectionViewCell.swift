//
//  CategoryCollectionViewCell.swift
//  3emala
//
//  Created by YoussefRomany on 2/12/20.
//  Copyright © 2020 hardTask. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var catNameLabel: UILabel!
    @IBOutlet var categoryImageView: RoundedImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}


//MARK:- Helpers
extension CategoryCollectionViewCell{
    
    /// init cell
    func initCell(withCategory category: CatOrder){
        catNameLabel.text = category.name
        categoryImageView.image = UIImage(named: category.image)

    }

}
