//
//  SettingViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/11/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import ActionSheetPicker_3_0
import SwiftyJSON
class SettingViewController: UIViewController {
    @IBOutlet weak var language: SkyFloatingLabelTextField!
    @IBOutlet weak var lanugaImage: UIImageView!
    @IBOutlet weak var notficationsImage: UIImageView!
    @IBOutlet weak var firstCheackBox: Checkbox!
    @IBOutlet weak var secondCheackBox: Checkbox!
    @IBOutlet weak var changeLangugeBtn: UIButton!
    @IBOutlet weak var thirdCheackBox: Checkbox!
    let paragraphStyle = NSMutableParagraphStyle()
    var Language = ""
    var langArray = ["English" , "عربي"]
    override func viewDidLoad() {
        super.viewDidLoad()
        cheackBoxStyel()
        self.lanugaImage.image = #imageLiteral(resourceName: "language")
        self.notficationsImage.image = #imageLiteral(resourceName: "notification")
        self.firstCheackBox.layer.cornerRadius = 10
        self.secondCheackBox.layer.cornerRadius = 10
        self.thirdCheackBox.layer.cornerRadius = 10
        self.navigationItem.title = "Settings".localized()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        if(getServerLang() == "ar"){
            self.changeLangugeBtn.setTitle("عربي", for: .normal)
        }else{
            self.changeLangugeBtn.setTitle("English", for: .normal)
        }
    }
    
    @IBAction func changeLanguageAction(_ sender: Any) {
        paragraphStyle.alignment = .center
        
        let pick2 = ActionSheetStringPicker(title: "Change Language".localized(), rows: self.langArray, initialSelection: 1, doneBlock: {
            picker, indexes, values in
            print(indexes)
            print(values!)
            self.Language = values as! String
             self.changeLangugeBtn.setTitle( self.Language, for: .normal)
            
           self.actionPickerDone()
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        let bar1 = UIBarButtonItem.init(title: "Done".localized(), style: .plain, target: self, action: #selector(actionPickerDone))
        let bar2 = UIBarButtonItem.init(title: "Cancel".localized(), style: .plain, target: self, action: #selector(actionPickerCancel))
        
        bar1.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 20) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)], for: .normal)
        bar2.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 20) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)], for: .normal)
        
        
        
        pick2?.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular" , size: 20) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)]
        
        pick2?.setDoneButton(bar1)
        pick2?.setCancelButton(bar2)
        
        pick2?.pickerTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 17) as Any, NSAttributedStringKey.paragraphStyle: paragraphStyle]
        pick2?.show()
    }
    @objc func actionPickerCancel(){
        
        print("Cancel")
    }
    @objc func actionPickerDone(){
        if(self.Language == "English"){
            print("en")
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            LocalizeBase.changeLanguageToEnglish()
             self.changeLang(lang: "en")
            
        }else{
            print("ar")
             defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            LocalizeBase.changeLanguageToArabic()
             self.changeLang(lang: "ar")
         
        }
    }
    
    func changeLang(lang : String){
        
        self.startAnimating()
        
        API.POST(url: UPDATE_LANG, parameters: ["lang" : lang , "user_id" : getUserID()] as [String: AnyObject], headers: nil, completion: {
            ( succeeded: Bool,  result: [String: AnyObject]) in
            if succeeded {
                 self.stopAnimating()
                let statuse = JSON(result["status"]!).stringValue
                print("🥥\(result)")
                if statuse == "1"{
                    if let msg = result["msg"] as? String {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            guard let window = UIApplication.shared.keyWindow else { return }
                            var vc = MyTabBAr()
                            vc = Storyboard.Main.instantiate(MyTabBAr.self)
                            window.rootViewController = vc
                        }
                       
                    }
                    
                }else {
                  
                    
                }
                
            }else {
                self.stopAnimating()
               
                
            }
        })
        
    }
    
    
    
    
    
    
    
    func cheackBoxStyel(){
        firstCheackBox.borderStyle = .circle
        firstCheackBox.checkmarkColor = UIColor.white
        firstCheackBox.checkmarkStyle = .circle
        firstCheackBox.checkmarkColor =  #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        firstCheackBox.uncheckedBorderColor = UIColor.gray
        firstCheackBox.borderWidth = 2
        firstCheackBox.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        firstCheackBox.checkedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        firstCheackBox.uncheckedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        
        secondCheackBox.borderStyle = .circle
        secondCheackBox.checkmarkColor = UIColor.white
        secondCheackBox.checkmarkStyle = .circle
        secondCheackBox.checkmarkColor =  #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        secondCheackBox.uncheckedBorderColor = UIColor.gray
        secondCheackBox.borderWidth = 2
        secondCheackBox.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        secondCheackBox.checkedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        secondCheackBox.uncheckedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)

        
        thirdCheackBox.borderStyle = .circle
        thirdCheackBox.checkmarkColor = UIColor.white
        thirdCheackBox.checkmarkStyle = .circle
        thirdCheackBox.checkmarkColor =  #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        thirdCheackBox.uncheckedBorderColor = UIColor.gray
        thirdCheackBox.borderWidth = 2
        thirdCheackBox.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        thirdCheackBox.checkedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        thirdCheackBox.uncheckedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)

    }
}
