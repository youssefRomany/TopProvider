//
//  NotficationCellTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/22/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SnapKit
class NotficationCellTableViewCell: UITableViewCell {
    @IBOutlet weak var notficationNumber: UILabel!
    @IBOutlet weak var notficationMassge: UILabel!
    @IBOutlet weak var notficationDelet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notficationMassge.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func dropShadow() {
        self.clipsToBounds = true;
        self.contentView.layer.masksToBounds = true;
        self.layer.masksToBounds = false
        self.layer.mask?.cornerRadius = 4
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 4.0, height: 3.0)
        self.layer.shadowRadius = 3
        
        
        
    }
}
