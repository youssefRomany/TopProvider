//
//  LoginViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/8/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LoginViewController: UIViewController {
    @IBOutlet weak var backGround: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var userName: BorderBaddedTextField!
    @IBOutlet weak var userNameIcon: UIImageView!
    @IBOutlet weak var password: BorderBaddedTextField!
    @IBOutlet weak var passwordIcon: UIImageView!
    @IBOutlet weak var LoginBtn: RoundedButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.backGround.image = #imageLiteral(resourceName: "bg")
        self.logo.image = #imageLiteral(resourceName: "logo")
        self.userNameIcon.image = #imageLiteral(resourceName: "user")
        self.passwordIcon.image = #imageLiteral(resourceName: "password")
        self.userName.keyboardType = .asciiCapableNumberPad
        self.password.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.userName.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.userName.layer.borderWidth = 2
        self.password.layer.borderWidth = 2
        self.password.placeHolderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.hideKeyboardWhenTappedAround()
        print("🎢\(AppDelegate.FCMTOKEN)")

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true

    }
    @IBAction func forgetPassAction(_ sender: Any) {
         let Home = Storyboard.Main.instantiate(EnterMobileViewController.self)
        self.navigationController?.pushViewController(Home, animated: true)
    }
    
    @IBAction func registrtAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(RegisterFirstStepViewController.self)
        self.navigationController?.pushViewController(Home, animated: true)
    }
    
    
    
    @IBAction func LoginAction(_ sender: Any) {
        if(userName.text?.isEmpty == true || password.text?.isEmpty == true){
            self.LoginBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "You must Complate your Data".localized(), title: "Error".localized())
        }else{
            self.startAnimating()
            self.LoginNewUser(phone: self.userName.text!, password: self.password.text!)
        }
    }
    
    func LoginNewUser(phone:String,password:String){
        let params: Parameters = [
            "phone": phone,
            "password":password,
            "device":"1",
            "device_id":AppDelegate.FCMTOKEN,
            "lang":getServerLang()
        ]
        
        print(params, "rrrrrrrrr")
        Alamofire.request(Login_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers:[:]).responseJSON{(response: DataResponse<Any>) in
            print(response.response?.statusCode, "oiuytreertyuio")
            switch(response.result){
            case .success(let data):
                print("👏🏻\(response)")
                let json = JSON(data)
                let msg = json["msg"].string
                let status = json["status"].int
                self.stopAnimating()
                if(status == 1){
                    self.stopAnimating()
                    let user_id = json["data"]["user_id"].int
                    let avatar = json["data"]["avatar"].string
                    let name = json["data"]["name"].string
                    let email = json["data"]["email"].string
                    let phone = json["data"]["phone"].string
                    let civil_number = json["data"]["civil_number"].string
                    let nationality_name = json["data"]["nationality_name"].string
                    let city_name = json["data"]["city_name"].string
                    let city_id = json["data"]["city_id"].int
                    let nationality_id = json["data"]["nationality_id"].int
                    let type = json["data"]["type"].string
                    let shop_id = json["data"]["shop"]["shop_id"].intValue
                    let shop_Name = json["data"]["shop"]["shop_name"].stringValue

                    
                    print(shop_id, "mmmmvermvlreviernver")

                    if(type == "client" ){
                        self.self.stopAnimating()
                         ShowErrorMassge(massge: "This account does not match your account".localized(), title: "Error".localized())
                    }else{
                        self.stopAnimating()
                    
                    self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3286560178, green: 0.7481182814, blue: 0.6407282948, alpha: 1)
                    defaults.set(shop_id, forKey: SHOP_ID)
                    defaults.set(shop_Name, forKey: SHOP_NAME)
                    defaults.set(String(describing:user_id!), forKey: User_ID)
                    defaults.set(avatar, forKey: User_Avatar)
                    defaults.set("user", forKey: LoggedNow)
                    defaults.set(name, forKey: User_Name)
                    defaults.set(phone, forKey: User_Phone)
                    defaults.set(city_name, forKey: User_CityName)
                    defaults.set(email, forKey: User_Email)
                    defaults.set(nationality_name, forKey: User_NationaltyName)
                    defaults.set(civil_number!, forKey: User_CivilNumber)
                    defaults.set(String(city_id!), forKey: User_CityID)
                    defaults.set(String(describing: nationality_id!), forKey: User_NationaltyID)
                    ShowTrueMassge(massge: "Logged in successfully".localized(), title: "")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of
                        self.goToHome()
                        
                    }
                    }
                }else if (status == 2){
                    self.stopAnimating()
                    let user_id = json["data"]["user_id"].int
                    defaults.set(String(describing:user_id!), forKey: User_ID)
                    ShowTrueMassge(massge: "You will be redirected to the activation page".localized(), title: "Succsses".localized())
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of
                        self.VrefCode()
                        
                        
                    }
                    
                    
                }else{
                    self.stopAnimating()
                    self.LoginBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                    ShowErrorMassge(massge: msg!, title: "Error".localized())
                }
            case .failure(_):
                self.stopAnimating()
                print("faild")
                
            }
        }
        
    }
    
    func VrefCode(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let InstrcationsViewController = storyBoard.instantiateViewController(withIdentifier: "VreficationCodeViewController") as! VreficationCodeViewController
            defaults.set("reg", forKey: VrefFrom)
        self.navigationController?.pushViewController(InstrcationsViewController, animated: true)
        
    }
    func goToHome(){
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        var vc = MyTabBAr()
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyTabBAr") as! MyTabBAr
        window.rootViewController = vc
    }
    
}
