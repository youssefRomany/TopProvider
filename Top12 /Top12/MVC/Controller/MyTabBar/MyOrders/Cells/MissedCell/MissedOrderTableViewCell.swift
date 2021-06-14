//
//  MissedOrderTableViewCell.swift
//  Top12
//
//  Created by YoussefRomany on 5/11/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit

class MissedOrderTableViewCell: UITableViewCell {

    @IBOutlet var logoView: UIImageView!
    @IBOutlet var orderNumLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var orderStatuseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initCell(withOrder order:Final){
        orderNumLabel.text = "Order Number :".localized() + " " + String(describing: order.order_id ?? 0)
        cityLabel.text = order.order_city ?? ""
        logoView.layer.borderWidth = 1
        logoView.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        logoView.image = UIImage(named: "logo")
        let langStr = Locale.current.languageCode ?? ""
        print(order.order_status, "mmmmmmmmmmmm")
        switch order.order_status ?? "" {
        case "client refused":
            orderStatuseLabel.text = (langStr == "ar") ? "الغاء العميل" : (order.order_status ?? "")
            orderStatuseLabel.textColor = UIColor(hexString: "249A3F")
        case "order failed":
//            orderStatuseLabel.textColor = .red
            orderStatuseLabel.textColor = UIColor(hexString: "D73B33")
            orderStatuseLabel.text = (langStr == "ar") ? "انقضاء وقت الموافقه" : (order.order_status ?? "")
        case "provider refused":
            if order.isEarly ?? false{
                orderStatuseLabel.textColor = UIColor(hexString: "7DBC7F")
                orderStatuseLabel.text = (langStr == "ar") ? "الغاء المتجر-طلب مشروط" : (order.order_status ?? "")
            }else{
//                orderStatuseLabel.textColor = .red
                orderStatuseLabel.textColor = UIColor(hexString: "C74854")

                orderStatuseLabel.text = (langStr == "ar") ? "الغاء المتجر" : (order.order_status ?? "")
            }
        default:
            break
        }

    }
    
}
