//
//  ComplmintsViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/11/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SwiftyJSON
import SkyFloatingLabelTextField
class ComplmintsViewController: UIViewController {
    
    @IBOutlet weak var sentBtn: UIButton!
    @IBOutlet weak var complainMsg: UITextView!
    @IBOutlet weak var complainTitle: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
        self.navigationItem.title = "Complaint".localized()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.complainMsg.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]


    }
    
    func setUpview(){
      
        sentBtn.layer.cornerRadius = 5
        complainMsg.layer.cornerRadius = 5
        complainMsg.layer.borderWidth = 1
        complainMsg.layer.borderColor = UIColor.lightGray.cgColor
        complainTitle.placeholder = "Complaint title".localized()
        sentBtn.setTitle("sent complaint".localized(), for: .normal)
        self.hideKeyboardWhenTappedAround()
         complainMsg.textColor = UIColor.lightGray
        complainMsg.delegate = self
        
    }

    @IBAction func sent(_ sender: Any) {
        if (complainMsg.text.count == 0 ||  complainTitle.text?.count == 0){
            self.sentBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "Please Complete Your data".localized(), title: "Eror".localized())
        }else{
            self.startAnimating()
            self.sentComplaint(user_id: getUserID())
        }
    }
    func sentComplaint(user_id:String){
 let parameters = ["user_id": user_id , "lang" : getServerLang() , "title" : complainTitle.text! , "body" : complainMsg.text!]  as [String: AnyObject]
        print("🥝\(parameters)")
        API.POST(url: Complmint_Url, parameters: parameters, headers: nil, completion: {
            ( succeeded: Bool,  result: [String: AnyObject]) in
            if succeeded {
                self.stopAnimating()
                let statuse = JSON(result["status"]!).int
                print("🥥\(result)")
                if statuse == 1{
                    self.complainTitle.text = ""
                    self.complainMsg.textColor = UIColor.lightGray
                    self.complainMsg.text = "Complaint datails".localized()
                    ShowTrueMassge(massge:"your compliant has been sent".localized() , title: "Success".localized())
                }else {
                    if let msg = JSON(result)["msg"].string {
                       ShowErrorMassge(massge: msg, title: "Error".localized())

                    }

                }

            }else {
                self.stopAnimating()
              

            }
        })
    }
}
extension ComplmintsViewController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "msg".localized(using: "Menu")
            textView.textColor = UIColor.lightGray
        }
    }
    
}

