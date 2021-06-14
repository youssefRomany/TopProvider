//
//  BillsDetailsViewController.swift
//  Top12
//
//  Created by YoussefRomany on 5/1/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit

class BillsDetailsViewController: UIViewController {

    @IBOutlet var deliverdCashLabel: UILabel!
    @IBOutlet var electronicMoney: UILabel!
    @IBOutlet var onTheTopMoney: UILabel!
    @IBOutlet var appMoney: UILabel!
//    @IBOutlet var remainingMoneyLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var gharamaLabel: UILabel!
    
    var bill: Bills!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "Bill Details".localized()
        
        deliverdCashLabel.text = "\(bill.cash ?? "") " + "SAR".localized()
        electronicMoney.text = "\(bill.epay ?? "") " + "SAR".localized()
        onTheTopMoney.text = "\(bill.pids ?? "") " + "SAR".localized()
        appMoney.text = "\(bill.app_fee ?? "") " + "SAR".localized()
        gharamaLabel.text = "\(bill.orderComplaint ?? "") " + "SAR".localized()

        let cash = Double(bill.cash ?? "") ?? 0.0
        let epay = Double(bill.epay ?? "") ?? 0.0
        let pids = Double(bill.pids ?? "") ?? 0.0
        let app_fee = Double(bill.app_fee ?? "") ?? 0.0
        balanceLabel.text = (bill.value ?? "") + " " + "SAR".localized()

        
//        remainingMoneyLabel.text = "\(bill.value ?? "") " + "SR".localized()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        navigationController?.popViewController(animated: false)
    }
    @IBAction func confirmAction(_ sender: Any) {
    }
    
    @IBAction func shippingAction(_ sender: Any) {
    }
    
    
}
