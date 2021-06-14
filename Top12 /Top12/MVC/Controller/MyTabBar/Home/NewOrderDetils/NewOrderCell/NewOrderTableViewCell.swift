//
//  NewOrderTableViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class NewOrderTableViewCell: UITableViewCell, UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var proudctName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var SpesialAdd: UILabel!
    @IBOutlet weak var addtionsTableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var noAdditions: UILabel!
    @IBOutlet weak var total: UILabel!
    var AddtionsData = [proudctAddtionsOrderModel]()
    
    @IBOutlet weak var hightTableView: NSLayoutConstraint!
    @IBOutlet weak var netPrice: UILabel!
    @IBOutlet weak var netPriceLbl: UILabel!
    @IBOutlet weak var commision: UILabel!
    @IBOutlet weak var provider_commison: UILabel!
    //=================

    override func awakeFromNib() {
        super.awakeFromNib()
        self.SpesialAdd.text! = "Special Additions".localized()
        configureMenuTableView()
        self.addtionsTableView.reloadData()
        addtionsTableView.delegate = self
        addtionsTableView.dataSource = self
        addtionsTableView.showsVerticalScrollIndicator = false
        self.noAdditions.isHidden = true
        provider_commison.text = "Net price".localized()
       // netPriceLbl.text = "Net price".localized()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
       return self.AddtionsData.count
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddtionsCellTableViewCell", for: indexPath) as! AddtionsCellTableViewCell
          cell.addtionsName.text = "sara"

        cell.addtionsName.text = self.AddtionsData[indexPath.row].addition_name!
        cell.addtionsPrice.text = String(describing: self.AddtionsData[indexPath.row].addition_price!) + " " + "SR".localized()
        return cell
    }
    func configureMenuTableView(){
        addtionsTableView.register(UINib(nibName: "AddtionsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "AddtionsCellTableViewCell")
            addtionsTableView.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
