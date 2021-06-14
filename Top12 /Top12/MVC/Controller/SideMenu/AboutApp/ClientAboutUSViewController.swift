//
//  ClientAboutUSViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 3/29/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SwiftyJSON

class ClientAboutUSViewController: UIViewController {
    
    
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var aboutText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        aboutApp()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        aboutText.textAlignment = .center
     
   
        logo.image = #imageLiteral(resourceName: "logo")
        self.greenView.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }
    @IBAction func openMenu(_ sender: Any) {
     
    }
    @IBAction func goBack(_ sender: Any) {
     
    }
    
    func aboutApp(){
        API.POST(url: about_URL, parameters: ["lang":getServerLang()], headers: nil) { (succeeded,value) in
            if succeeded {
                self.stopAnimating()
                let statuse = JSON(value["status"]!).int
                print("🥥\(value)")
                if statuse == 1{
                    if let data = value["data"] as? String {
                        
                        self.aboutText.text = data
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
