//
//  TermsandConftionsViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/11/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class TermsandConftionsViewController: UIViewController {
    @IBOutlet weak var TermsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Terms and Conditions".localized()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)

        self.startAnimating()
         self.navigationController?.isNavigationBarHidden = false
        getTerms()
        
        if (getTermsFrom() == "reg"){
         
        }else{

        }
    }
    
    func getTerms(){
       
        let params: Parameters = [
            
            "lang":getServerLang()
        ]
        Alamofire.request(Termis_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                 self.stopAnimating()
                let json = JSON(data)
                let data = json["data"].stringValue
                self.stopAnimating()
                if response.result.value != nil{
                    self.TermsTextView.text = data
                    print("😼\(response)")
                    
                }
            case .failure(_):
                print("faild")
                 self.stopAnimating()
                print("😼\(response.error)")
                
                
            }
        }
        
    }

}
