//
//  CustomDelgateAlertViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CustomDelgateAlertViewController: UIViewController {

    @IBOutlet weak var continerView: UIView!
    @IBOutlet weak var other: Checkbox!
    @IBOutlet weak var delagePrice: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var FamliCheackBox: Checkbox!
    var orderID = ""
    var haveDelgate :Bool?
    var shop_delegate :String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cheackBoxStyel()
        print("🗿\(self.orderID)")
        self.delagePrice.keyboardType = .asciiCapableNumberPad
        self.delagePrice.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        self.delagePrice.layer.borderWidth = 1
        self.delagePrice.layer.cornerRadius = 10
        self.other.layer.cornerRadius = 10
        self.FamliCheackBox.layer.cornerRadius = 10
        self.FamliCheackBox.addTarget(self, action:  #selector(FamlyCheack(sender:)), for: .valueChanged)
        self.hideKeyboardWhenTappedAround()
        self.other.addTarget(self, action:  #selector(OtherCheack(sender:)), for: .valueChanged)
    }
    @objc func FamlyCheack(sender: Checkbox){
        self.other.isChecked = false
        
        self.FamliCheackBox.isEnabled = false
        self.other.isEnabled = true
        
        self.haveDelgate = true
        self.shop_delegate = "yes"
        
    }
    @objc func OtherCheack(sender: Checkbox){
        self.FamliCheackBox.isChecked = false
         self.haveDelgate = false
        self.FamliCheackBox.isEnabled = true
        self.other.isEnabled = false
        
        self.shop_delegate = "no"

    }
    
    func cheackBoxStyel(){
        other.borderStyle = .circle
        other.checkmarkColor = UIColor.white
        other.checkmarkStyle = .circle
        other.checkmarkColor =  #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        other.uncheckedBorderColor = UIColor.gray
        other.borderWidth = 2
        other.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        other.checkedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        
        
        FamliCheackBox.borderStyle = .circle
        FamliCheackBox.checkmarkColor = UIColor.white
        FamliCheackBox.checkmarkStyle = .circle
        FamliCheackBox.checkmarkColor =  #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        FamliCheackBox.uncheckedBorderColor = UIColor.gray
        FamliCheackBox.borderWidth = 2
        FamliCheackBox.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        FamliCheackBox.checkedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
        self.changeState(order_id: self.orderID, status: "refuse", user_id: getUserID(), shop_delegate: "", delegate_price: "")
    }
    
    @IBAction func Confirmation(_ sender: Any) {
        if(haveDelgate == false){
            self.startAnimating()
            self.changeState(order_id: self.orderID, status: "accept", user_id: getUserID(), shop_delegate: self.shop_delegate!, delegate_price:self.delagePrice.text!)
        }else{
            if(self.delagePrice.text?.isEmpty == true){
                self.confirmBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                ShowErrorMassge(massge:"You must Complate your Data".localized(), title: "Success".localized())
                }else{
                if(self.shop_delegate == nil){
                    self.confirmBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                    ShowErrorMassge(massge:"Please select the delegate".localized(), title: "Success".localized())
                }else{
                self.startAnimating()
                self.changeState(order_id: self.orderID, status: "accept", user_id: getUserID(), shop_delegate: self.shop_delegate!, delegate_price:self.delagePrice.text!)
                }
            }
        }
    }
    
    
    func changeState(order_id:String,status:String,user_id:String,shop_delegate:String,delegate_price:String){
        let params: Parameters = [
            "order_id":order_id,
            "lang":getServerLang(),
            "status":status,
            "user_id":user_id,
            "shop_delegate":shop_delegate,
            "delegate_price":delegate_price
            
        ]
        
         print("😂\(params)")
        Alamofire.request(RacceptOrRefuse_URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                self.stopAnimating()
                let json = JSON(data)
                let status = json["status"].int
                let msg = json["msg"].string
                print("😂\(data)")
                 if(status == 1){
                    ShowTrueMassge(massge: msg!, title: "Succss".localized())
                    self.removeFromParentViewController()
                    self.view.removeFromSuperview()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of
                        self.goToHome()
                    }
                }else{
                    ShowErrorMassge(massge: msg!, title: "Error".localized())
                }
            case .failure(_):
                print("faild")
                self.stopAnimating()
                print("😼\(response.error)")
            }
        }
        
    }
    func goToHome(){
        guard let window = UIApplication.shared.keyWindow else { return }
        
        var vc = MyTabBAr()
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyTabBAr") as! MyTabBAr
        window.rootViewController = vc
    }
}
