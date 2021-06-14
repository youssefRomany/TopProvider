//
//  billsTableViewCell.swift
//  Top12
//
//  Created by YoussefRomany on 4/30/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit

class billsTableViewCell: UITableViewCell {

    @IBOutlet var billStatus: UILabel!
    @IBOutlet var billIconeImageView: UIImageView!
    @IBOutlet var billNumberLabel: UILabel!
    @IBOutlet var billDate: UILabel!
    @IBOutlet var titleBillLAbel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(withBill bill: Bills){
            billStatus.text = "not Paid".localized()

//        if (bill.status ?? 0) == 0{
//            billStatus.text = "not Paid".localized()
//            billStatus.textColor = .red
//            billIconeImageView.image = UIImage(named: "close")
//        }else{
//            billStatus.text = "Paid done".localized()
//            billStatus.textColor = .green
//            billIconeImageView.image = UIImage(named: "correct")
//
//        }
        billNumberLabel.text = "\("Bill Number: ".localized()) \(bill.id ?? 0)"
        billDate.text = "\("Bill Date: ".localized()) \("From".localized()) \(bill.start ?? "0" ) \("To".localized()) \(bill.end ?? "")"
        
        
//        billIconeImageView.setImageWith(cart.product_name)
    }
    
}


