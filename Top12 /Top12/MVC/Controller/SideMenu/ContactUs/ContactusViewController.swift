//
//  ContactusViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/11/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class ContactusViewController: UIViewController {
    var FBLink = ""
    var phoneNumber = ""
    
    @IBOutlet weak var FBBtn: UIButton!
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startAnimating()
        contactUS()
        self.navigationItem.title = "Call us".localized()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    
    @IBAction func gotoFB(_ sender: Any) {
        if let link = URL(string: FBLink) {
            UIApplication.shared.open(link)
        }
    }
    
    
    
    @IBAction func makeCall(_ sender: Any) {
        if let phone = URL(string: "tel://" + self.phoneNumber) {
            UIApplication.shared.open(phone, options: [:], completionHandler: nil)
        }
    }
func contactUS(){
        API.POST(url: AppInfo_Url, parameters: ["lang":getServerLang()], headers: nil) { (succeeded,value) in
            if succeeded {
                self.stopAnimating()
                let statuse = JSON(value["status"]!).int
                print("🥥\(value)")
                if statuse == 1{
                    if let data = value["data"] as? [String : Any] {
                        self.phone.setTitle(JSON(data["phone"]!).string, for: .normal)
                        self.email.text = JSON(data["email"]!).string
                        self.FBLink = JSON(data["facebook"]!).string!
                        self.phoneNumber = JSON(data["phone"]!).stringValue
                    }
                    
                }else {
                    if let msg = JSON(value)["msg"].string {
                        ShowErrorMassge(massge: msg, title: "Erroe".localized())
                        
                    }
                    
                }
                
            }else {
                 self.stopAnimating()
            }
        }
    }
}
