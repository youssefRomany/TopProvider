//
//  VreficationCodeViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/8/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class VreficationCodeViewController: UIViewController {
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var vrefCode: BorderBaddedTextField!
    @IBOutlet weak var vrefBtn: RoundedButton!
    
    var Code = ""
    
    @IBAction func vrefAction(_ sender: Any) {
        if(vrefCode.text?.isEmpty == true){
            self.vrefBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "Please Complete Your data".localized(), title: "Eror".localized())
        }else{
            if(getVrefFrom() == "reg"){
                if(self.vrefCode.text! == self.Code){
                    self.startAnimating()
                    self.CheackCode(code:self.vrefCode.text! , user_id: getUserID())
                }else{
                    self.vrefBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                    ShowErrorMassge(massge: "The code is incorrect".localized(), title: "Eror".localized())
                }
              
            }else{
                
                if(self.vrefCode.text! == self.Code){
                    self.startAnimating()
                    self.VereficationCode(code: self.vrefCode.text!, user_id: getUserID())
                }else{
                    self.vrefBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                    ShowErrorMassge(massge: "The code is incorrect".localized(), title: "Eror".localized())
                }
                
                
              
            }
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backGroundImage.image = #imageLiteral(resourceName: "bg")
        self.vrefCode.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.vrefCode.layer.borderWidth = 1
        self.hideKeyboardWhenTappedAround()
         self.vrefCode.keyboardType = .asciiCapableNumberPad
    }
    
    func CheackCode(code:String,user_id:String){
        let params: Parameters = [
            "lang":getServerLang(),
            "code":code,
            "user_id":user_id
        ]
        Alamofire.request(CheackCode_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let status = json["status"].int
                let msg = json["msg"].string
                print("👏🏻\(params)")
                self.stopAnimating()
                print("😼\(response)")
                if(status == 1){
                    ShowTrueMassge(massge: msg!, title: "")
                   // ShowTrueMassge(massge:"Vrefication Code is Error".localized(), title: "Succsses".localized())
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // change 2 to desired number of
                        self.GoToLogin()
                        
                    }
                }else{
                    self.vrefBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                     ShowErrorMassge(massge: msg!, title: "Eror".localized())
                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
        }
        
    }
    
    
    func VereficationCode(code:String,user_id:String){
        let params: Parameters = [
            "lang":getServerLang(),
            "code":code,
            "user_id":user_id
        ]
        Alamofire.request(CodeUpdatePass_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let status = json["status"].int
                let msg = json["msg"].string
                print("👏🏻\(params)")
                self.stopAnimating()
                print("😼\(response)")
                if(status == 1){
                    ShowTrueMassge(massge: msg!, title: "Succsses".localized())
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // change 2 to desired number of
                        self.ChangePassword()
                        
                    }
                }else{
                    self.vrefBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                      ShowErrorMassge(massge: "Vrefication Code is Error".localized(), title: "Eror".localized())
                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
        }
        
    }
    
    func GoToLogin(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let InstrcationsViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(InstrcationsViewController, animated: true)
    }
    
    func ChangePassword(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let InstrcationsViewController = storyBoard.instantiateViewController(withIdentifier: "ReasetPasswordViewController") as! ReasetPasswordViewController
        self.navigationController?.pushViewController(InstrcationsViewController, animated: true)
    }
    

}
