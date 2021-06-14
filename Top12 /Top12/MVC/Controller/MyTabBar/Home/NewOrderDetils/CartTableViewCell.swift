//
//  CartTableViewCell.swift
//  Top_Client
//
//  Created by YoussefRomany on 4/17/20.
//  Copyright © 2020 Engy Bakr. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var productImageView: RoundedImage!
    
    
    var CurrentCart: joeOrder_products!
    var parent: UIViewController!
    var currentIndex = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}


extension CartTableViewCell{
    
    func configureCell(withcart cart: joeOrder_products, fromController controller: UIViewController, withIndex index: Int){
        CurrentCart = cart
        parent = controller
        currentIndex = index
        nameLabel.text = cart.product_name
        priceLabel.text =  "price : ".localized() + "\(cart.product_price)" + "SR".localized()
        quantityLabel.text = "\(cart.product_count ?? 0)"
        productImageView.setImageWith(cart.product_image)
        print("wwwwwwwww")

        if let additions = cart.product_additions{
            var str = ""
            
            for addition in additions{
                if (addition.addition_count ?? 0) != 0{
               let s = "(\(addition.addition_count ?? 0)) : " + (addition.addition_name ?? "")
                str += s + "\n"
                }
            }
            if additions.count > 0{
                descriptionLabel.text = str
            }
            
            if str == ""{
                descriptionLabel.text = "No Additions".localized()
            }

        }


//        downloadImg(imgStr: cart.product_image, image: productImageView)
    
        
    }
    
}
