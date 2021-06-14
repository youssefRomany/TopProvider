//
//  ReasetPasswordViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/8/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ReasetPasswordViewController: UIViewController {
 @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var password: BorderBaddedTextField!
    @IBOutlet weak var passwordConfirmation: BorderBaddedTextField!
    @IBOutlet weak var sendBtn: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backGroundImage.image = #imageLiteral(resourceName: "bg")
        self.password.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.password.layer.borderWidth = 1
        self.passwordConfirmation.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.passwordConfirmation.layer.borderWidth = 1
        self.password.placeHolderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.passwordConfirmation.placeHolderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
         self.hideKeyboardWhenTappedAround()
    }

    @IBAction func sendAction(_ sender: Any) {
        
        if(password.text?.isEmpty == true || passwordConfirmation.text?.isEmpty == true){
            
            self.sendBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "You must Complate your Data".localized(), title: "Error".localized())
        }else{
            if(password.text != passwordConfirmation.text){
                self.sendBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                ShowErrorMassge(massge: "Password and Password Confirmation didn't match".localized(), title: "Error".localized())
            }else{
                self.startAnimating()
                self.UpdatePassword(password: self.password.text!, user_id:getUserID())
            }
        }
    }
    func UpdatePassword(password:String,user_id:String){
        let params: Parameters = [
            "lang":getServerLang(),
            "password":password,
            "user_id":user_id
        ]
        Alamofire.request(UpdatePassword_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let status = json["status"].int
                let msg = json["msg"].string
                
                self.stopAnimating()
                print("👏🏻\(params)")
                if(status == 1){
                    ShowTrueMassge(massge: msg!, title: "Succsses".localized())
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of
                        self.LoginPage()
                        
                    }
                }else{
                    self.sendBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                    ShowErrorMassge(massge: msg!, title: "Eror".localized())
                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
        }
        
    }
    func LoginPage(){
        let forgetPass = Storyboard.Main.instantiate(LoginViewController.self)
        self.navigationController?.pushViewController(forgetPass, animated: true)
        
    }

}
