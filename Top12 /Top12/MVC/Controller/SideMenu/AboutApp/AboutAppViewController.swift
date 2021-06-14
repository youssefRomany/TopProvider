//
//  AboutAppViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/11/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class AboutAppViewController: UIViewController {
    @IBOutlet weak var logo: RoundedImage!
    @IBOutlet weak var continerView: UIView!
    @IBOutlet weak var textViewApout: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logo.image = #imageLiteral(resourceName: "logo")
        self.continerView.roundCorners([.topLeft,.topRight], radius: 30)
        self.textViewApout.roundCorners([.bottomLeft,.bottomRight], radius: 30)
        self.navigationItem.title = "About App".localized()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        self.startAnimating()
        aboutApp()
    }
    func aboutApp(){
        API.POST(url: about_URL, parameters: ["lang":getServerLang()], headers: nil) { (succeeded,value) in
            if succeeded {
                self.stopAnimating()
                let statuse = JSON(value["status"]!).int
                print("🥥\(value)")
                if statuse == 1{
                    if let data = value["data"] as? String {
                        
                        self.textViewApout.text = data
                    }
                    
                }else {
                    if let msg = JSON(value)["msg"].string {
                        ShowErrorMassge(massge: msg, title: "Error".localized())
                        
                    }
                    
                }
                
            }else {
                self.stopAnimating()
            }
        }
        
    }

}
