//
//  EnterMobileViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/8/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class EnterMobileViewController: UIViewController {

    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var vrefCode: BorderBaddedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .clear
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
        self.vrefCode.keyboardType = .asciiCapableNumberPad
        self.navigationController?.isNavigationBarHidden = false
        self.backGroundImage.image = #imageLiteral(resourceName: "bg")
        self.vrefCode.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.vrefCode.layer.borderWidth = 1
    }
    
    @IBAction func vrafAction(_ sender: Any) {
        
        if(vrefCode.text?.isEmpty == true){
            self.vrefCode.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "You must Complate your Data".localized(), title: "Error".localized())
        }else{
            self.startAnimating()
            self.EnterYourMobilenumber(phone: self.vrefCode.text!)
        }
    }
    func EnterYourMobilenumber(phone:String){
        let params: Parameters = [
            "phone": phone,
            "lang":getServerLang()
        ]
        Alamofire.request(ForgetPassword_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers:[:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                
                let json = JSON(data)
                let msg = json["msg"].string
                let status = json["status"].int
                self.stopAnimating()
                if(status == 1){
                    print("👏🏻\(response)")
                    let user_id = json["data"]["user_id"].int
                    let user_code = json["data"]["user_code"].string
                    defaults.set(String(describing:user_id!), forKey: User_ID)
                    ShowTrueMassge(massge: msg!, title:"")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        let forgetPass = Storyboard.Main.instantiate(VreficationCodeViewController.self)
                        defaults.set("pass", forKey: VrefFrom)
                        forgetPass.Code = user_code!
                        self.navigationController?.pushViewController(forgetPass, animated: true)
                    }
                    
                }else{
                    self.vrefCode.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                    ShowErrorMassge(massge: msg!, title: "Error".localized())
                }
            case .failure(_):
                print("faild")
                
            }
        }
        
    }
    
    
    func EnterVrefCode(){
        let forgetPass = Storyboard.Main.instantiate(VreficationCodeViewController.self)
        defaults.set("pass", forKey: VrefFrom)
        self.navigationController?.pushViewController(forgetPass, animated: true)
    }
    
}
