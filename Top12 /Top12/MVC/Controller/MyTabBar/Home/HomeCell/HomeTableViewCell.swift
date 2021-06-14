//
//  HomeTableViewCell.swift
//  Top12
//
//  Created by YoussefRomany on 12/09/2020.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var catImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailseLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var arrowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print(getServerLang(), "fwefwefewfwefwe")
        if getServerLang() == "ar"{
            mainQueue {
                self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }

        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(withCat cat: CatOrder){
        catImageView.image = UIImage(named: cat.image)
        titleLabel.text = cat.name
        detailseLabel.text = cat.details
        countLabel.text = "\(cat.counter)"
        
    }
}
