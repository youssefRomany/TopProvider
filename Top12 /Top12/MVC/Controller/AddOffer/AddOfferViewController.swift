//
//  AddOfferViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 3/21/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AddOfferViewController: UIViewController {
    var priceBefore = ""
    @IBOutlet weak var addOfferTitle: UILabel!
    @IBOutlet weak var pricebefore: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var priceafteroffer: UILabel!
    @IBOutlet weak var Offer: UITextField!
    @IBAction func cancelBtn(_ sender: Any) {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBAction func donBtnAction(_ sender: Any) {
        if(Offer.text?.isEmpty == true){
            self.doneBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "Please Complete Your data".localized(), title: "Eror".localized())
        }else{
            self.startAnimating()
            self.addOffer(product_id: self.offerID, offer_price: self.Offer.text!)
        }
    }
    var offerID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addOfferTitle.text = "Add Offer".localized()
        self.pricebefore.text =  priceBefore + " " + "SR".localized()
        self.priceafteroffer.text = "Price after Offer".localized()
        self.hideKeyboardWhenTappedAround()
        self.Offer.keyboardType = .asciiCapableNumberPad
        print("😋\(self.offerID)")
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
