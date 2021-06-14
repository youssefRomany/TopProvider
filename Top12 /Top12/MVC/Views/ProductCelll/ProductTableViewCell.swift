//
//  ProductTableViewCell.swift
//  Top12
//
//  Created by YoussefRomany on 4/14/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit

protocol ActiveDelegate {
    func activeAction(withIndex index: Int)
}

class ProductTableViewCell: UITableViewCell {


    @IBOutlet weak var productImage: RoundedImage!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDisc: UILabel!
    @IBOutlet var switchButton: UISwitch!
    
    @IBOutlet var productTypeLabel: UILabel!
    @IBOutlet var tupeView: RoundedView!

    
    var parent: UIViewController!
    var currentProduct: productsModel!
    var delegate: ActiveDelegate?
    var index = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func switchAvailableProductAction(_ sender: Any) {
        print(switchButton.isOn, "switchButton")
        delegate?.activeAction(withIndex: index)
    }
    
}


//MARK:- Helpers
extension ProductTableViewCell{
    
    func configureCell(withProductsModel product: productsModel, andParent controller: UIViewController, withIndex indexx: Int){
        currentProduct = product
        parent = controller
        self.index = indexx
        productImage.setImageWith(product.product_main_image)
        productName.text = product.product_name
        productDisc.text = product.product_disc
        productPrice.text = "Price".localized() + " : " + product.product_price! + " " + "SR".localized()
        if product.product_type == "instant"{
            productTypeLabel.text = "instant deliver".localized()
            tupeView.backgroundColor = .green
        }else{
            productTypeLabel.text = "Pre-order".localized()
            tupeView.backgroundColor = .red
        }
//        let isActive = (product.is_active ?? false )
        print("mmmmewcwedwe",product.is_active)
        mainQueue {
            self.switchButton.setOn((product.is_active ?? false), animated: false)
        }

    }
    
    func mainQueue(_ closure: @escaping ()->()){
        DispatchQueue.main.async(execute: closure)
    }
}



