//
//  waiteingOrdersTableViewCell.swift
//  Top12
//
//  Created by YoussefRomany on 5/10/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit


class waiteingOrdersTableViewCell: UITableViewCell {
    
    @IBOutlet var orderImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var orderNumLabel: UILabel!
    @IBOutlet var cashImageView: UIImageView!
    
    var currentOrder: Orders!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func initCell(withOrder order:Final){
        orderNumLabel.text = "Order Number :".localized() + " " + String(describing: order.order_id ?? 0)
        dateLabel.text = order.order_created_at ?? ""
        titleLabel.text = order.order_delegate
        cityLabel.text = order.order_city ?? ""
        orderImageView.layer.borderWidth = 1
        orderImageView.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        orderImageView.image = UIImage(named: "logo")
        if order.order_payment == "cash"{
            cashImageView.image = UIImage(named: "cash")
        }else{
            cashImageView.image = UIImage(named: "pay")
        }

    }
}


