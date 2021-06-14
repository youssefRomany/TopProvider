//
//  UnderDeleverdTableViewCell.swift
//  Top12
//
//  Created by YoussefRomany on 5/11/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit

class UnderDeleverdTableViewCell: UITableViewCell {

    
    @IBOutlet var logoView: UIImageView!
    @IBOutlet var orderNumLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var waitCapLabel: UILabel!
    @IBOutlet var waitIndicator: UIActivityIndicatorView!
    @IBOutlet var socialView: UIView!
    @IBOutlet var hintLabel: UILabel!
    
    
    var phone = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func callCaptinAction(_ sender: Any) {
        if phone != ""{
            makeCall(forNumber: phone)
        }
    }
    
    @IBAction func whatsAppAction(_ sender: Any) {
        openWhatsapp(forNumber: phone)
    }
    

    public func openWhatsapp(forNumber number:String){
        let urlWhats = "whatsapp://send?phone=" + number
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    func initCell(withOrder order:Final){
        orderNumLabel.text = "Order Number :".localized() + " " + String(describing: order.order_id ?? 0)
        cityLabel.text = order.order_city ?? ""
        logoView.layer.borderWidth = 1
        logoView.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        logoView.image = UIImage(named: "logo")
//        logoView.setImageWith(order.)
        
        print("orderorder_delegate", order.have_delegate, order.order_delegate, order.order_user?.phone ?? "")
        if order.have_delegate == "no"{
            phone = (order.order_delegate ?? "")
            print(order.order_delegate?.isEmpty ?? false, "orderorder_delegate   isEmpty", order.order_id ?? 0, "number", order.order_delegate ?? "1111")
            hintLabel.text = "Contact with captain".localized()

            if (order.order_delegate ?? "1111" != "1111"){
                print("orderorder_delegate   111")
                socialView.isHidden = false
               // foundCaptinLabel.text = "The delegate's mobile".localized()
             //   callCaptinButton.isHidden = false
                waitCapLabel.isHidden = false
                waitCapLabel.text = order.order_delegate ?? ""
                waitIndicator.isHidden = true
                waitIndicator.stopAnimating()
            }else{
                print("orderorder_delegate   2222")
                socialView.isHidden = true
                waitCapLabel.isHidden = false
               // callCaptinButton.isHidden = true
                waitIndicator.startAnimating()
                waitIndicator.isHidden = false
                waitCapLabel.text = "Waiting for captain".localized()

            }

        }else{
            // show client number and titlr only
            hintLabel.text = "Contact with Client".localized()
            print("hasNodelegate")
            socialView.isHidden = false
            waitCapLabel.isHidden = false
            //callCaptinButton.isHidden = false
            //foundCaptinLabel.text = "customer mobile".localized()
            waitCapLabel.text = order.order_user?.phone ?? ""
            waitIndicator.isHidden = true
            waitIndicator.stopAnimating()
            phone = (order.order_user?.phone ?? "")

        }


    }
    
    func makeCall(forNumber number:String)->Bool {
        let url:URL = URL(string:"tel://\(number)")!
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            return true
        }
        return false
    }
    
}
