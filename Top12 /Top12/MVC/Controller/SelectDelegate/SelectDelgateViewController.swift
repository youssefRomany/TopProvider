//
//  SelectDelgateViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 3/21/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SelectDelgateViewController: UIViewController {

    @IBOutlet weak var DelevryPlace: UITextField!
    @IBOutlet weak var otherDelgate: Checkbox!
    @IBOutlet weak var familyDElgate: Checkbox!
    @IBOutlet weak var confrimBtn: UIButton!
    @IBAction func reject(_ sender: Any) {
    }
    @IBAction func ConfirmAction(_ sender: Any) {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func addOffer(product_id:String,offer_price:String){
        let params: Parameters = [
            "user_id": getUserID(),
            "product_id":product_id,
            "offer_price":offer_price,
            "lang":getServerLang()
        ]
        Alamofire.request(addOffer_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let status = json["status"].int
                let msg = json["msg"].string
                print("😋\(response)")
                print("😁\(params)")
                self.stopAnimating()
                if(status == 1){
                    ShowTrueMassge(massge: "Offer successfully added".localized(), title: "success".localized())
                    self.removeFromParentViewController()
                    self.view.removeFromSuperview()
                }else{
                    ShowErrorMassge(massge: msg!, title: "Error".localized())
                    self.removeFromParentViewController()
                    self.view.removeFromSuperview()
                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
        }
        
    }

    
}
