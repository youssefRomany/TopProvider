//
//  RegisterFirstStepViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/8/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SwiftyJSON
import Alamofire
import Photos
class RegisterFirstStepViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    var lat:Double!
    var lng:Double!
    var params:Dictionary = [String:Any]()
    var CityNameArray = NSMutableArray()
    var CityArrayID = NSMutableArray()
    var CityID = ""
    var nationNameArray = NSMutableArray()
    var naationArrayID = NSMutableArray()
    var NationID = ""
    var flag1 = false
    var flag2 = false
    var flag4 = false
    var flag5 = false
    var utils = AppUtils.getObject()
    let timePicker = UIDatePicker()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var username: BorderBaddedTextField!
    @IBOutlet weak var nachoniltyBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var addNewImage: UIButton!
    @IBOutlet weak var password: BorderBaddedTextField!
    @IBOutlet weak var backgrond: UIImageView!
    @IBOutlet weak var passwordConfirmatiob: BorderBaddedTextField!
    @IBOutlet weak var backGround: UIImageView!
    @IBOutlet weak var email: BorderBaddedTextField!
    @IBOutlet weak var mobilenumber: BorderBaddedTextField!
    @IBOutlet weak var logo: UIImageView!
   // @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var location: BorderBaddedTextField!
    @IBOutlet weak var city: BorderBaddedTextField!
    @IBOutlet weak var nahionlty: BorderBaddedTextField!
    @IBOutlet weak var passicon: UIImageView!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var emailicon: UIImageView!
    @IBOutlet weak var passconIcon: UIImageView!
    @IBOutlet weak var mobilenumicon: UIImageView!
    @IBOutlet weak var cityicon: UIImageView!
    @IBOutlet weak var nachonicon: UIImageView!
    @IBOutlet weak var locationicon: UIImageView!
    @IBAction func addImage(_ sender: Any) {
        print("😃🔍hiiiiii")
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: false, completion: nil)
    }
    
    @IBOutlet weak var RegisterBtn: RoundedButton!
    @IBAction func gotoLogin(_ sender: Any) {
        let Reg = Storyboard.Main.instantiate(LoginViewController.self)
        self.navigationController?.pushViewController(Reg, animated: true)
    }
    
    @IBAction func registerAction(_ sender: Any) {

        if ( username.text?.count == 0 ){
            
            self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "You must Enter Your Name".localized(), title: "Error".localized())
            
        }else if(password.text?.count == 0){
            self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "You must Enter Your Password".localized(), title: "Error".localized())
        }else if(passwordConfirmatiob.text?.count == 0){
            self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "You must Enter Your Password Confirmation".localized(), title: "Error".localized())
        }else if(mobilenumber.text?.count == 0){
            self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "You must Enter Your Mobile number".localized(), title: "Error".localized())
        }else if (location.text?.count == 0){
            self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "You must Enter Your Location".localized(), title: "Error".localized())
        }
        
        
        else{
            
            if (utils.isValidMobileNumber(mobil:mobilenumber.text!)){
                flag1 = true
            }
            else{
                self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                ShowErrorMassge(massge: "Phone number is incorrect".localized(), title: "Error".localized())
                
                
            }
            if(password.text != passwordConfirmatiob.text){
                
                self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                ShowErrorMassge(massge: "Password and Password Confirmation didnt match".localized(), title: "Error".localized())
                
            }
            if(email.text?.count != 0){
                if (utils.isValidEmail(testStr: email.text!)){
                    flag5 = true
                }
                else{
                    
                    self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                    ShowErrorMassge(massge: "Email is incorrect".localized(), title: "Error".localized())
                    
                    
                }
            }else{
                 flag5 = true
            }
           
            if (utils.isValidpassword(mobil: password.text!)){
                
                flag2 = true
            }
            else{
                self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                ShowErrorMassge(massge: "You must increase your password for 6 symbols".localized(), title: "Error".localized())
            }
            if (flag1 && flag2 && flag5 && flag4 == true){
                
                print("truuuu🤦🏻‍♀️")
                let InstrcationsViewController = Storyboard.Main.instantiate(RegisterSecondStepViewController.self)
                InstrcationsViewController.name = self.username.text!
                InstrcationsViewController.email = self.email.text!
                InstrcationsViewController.password = self.password.text!
                InstrcationsViewController.phone = self.mobilenumber.text!
                InstrcationsViewController.imageData = self.imageData
                InstrcationsViewController.cityID = self.CityID
                InstrcationsViewController.NationltyID = self.NationID
             //   InstrcationsViewController.civil_number = self.personalNumber.text!
                InstrcationsViewController.lat = String(describing: self.lat!)
                InstrcationsViewController.lang = String(describing: self.lng!)
                InstrcationsViewController.selectedImage = self.logo.image
              
                self.navigationController?.pushViewController(InstrcationsViewController, animated: true)
                
                
            }else{
                self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                ShowErrorMassge(massge: "You must Chose your Profile Image".localized(), title: "Error".localized())
            }
        }
    }
    let paragraphStyle = NSMutableParagraphStyle()
    var imageStr = ""
    var imageData:Data!
    
    @IBAction func cityAction(_ sender: Any) {
        let pick2 = ActionSheetStringPicker(title: "Select your City".localized(), rows: self.CityNameArray as! [String], initialSelection: 0, doneBlock: {
            picker, indexes, values in
            print(indexes)
            print(values!)
        
            self.city.text = values as? String
            self.CityID = self.CityArrayID[indexes] as! String
            print("😠\(self.CityID)")
            
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        let bar1 = UIBarButtonItem.init(title: "Done".localized(), style: .plain, target: self, action: #selector(actionPickerDone))
        let bar2 = UIBarButtonItem.init(title: "Cancel".localized(), style: .plain, target: self, action: #selector(actionPickerDone))
        
        bar1.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 18) as Any, NSAttributedStringKey.foregroundColor:#colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)], for: .normal)
        bar2.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 18) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)], for: .normal)
        
        pick2?.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 18) as Any ,NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)]
        
        pick2?.setDoneButton(bar1)
        pick2?.setCancelButton(bar2)
        paragraphStyle.alignment = .center
        
        pick2?.pickerTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 17) as Any, NSAttributedStringKey.paragraphStyle: paragraphStyle,NSAttributedStringKey.foregroundColor: UIColor.gray]
        
        pick2?.show()
    }
    
    @objc func actionPickerDone(){
        
    }
    
    
    @IBAction func locationAction(_ sender: Any) {
        let Reg = Storyboard.Main.instantiate(GetLocationViewController.self)
        Reg.delegate = self
        self.navigationController?.pushViewController(Reg, animated: true)
        
    }
    @IBAction func NachoniltyAction(_ sender: Any) {
        
        let pick2 = ActionSheetStringPicker(title: "Select your Nationilty".localized(), rows: self.nationNameArray as! [String], initialSelection: 0, doneBlock: {
            picker, indexes, values in
            print(indexes)
            print(values!)
            
            //   self.City.text = values as? String
            // self.countryCode.setTitle(values as? String, for: .normal)
            
            self.nahionlty.text = values as? String
            self.NationID = self.naationArrayID[indexes] as! String
            print("😠\(self.CityID)")
            
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)

        let bar1 = UIBarButtonItem.init(title: "Done".localized(), style: .plain, target: self, action: #selector(actionPickerDone))
        let bar2 = UIBarButtonItem.init(title: "Cancel".localized(), style: .plain, target: self, action: #selector(actionPickerDone))
        bar1.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 18) as Any, NSAttributedStringKey.foregroundColor:#colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)], for: .normal)
        bar2.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 18) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)], for: .normal)
        pick2?.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 18) as Any ,NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)]
        pick2?.setDoneButton(bar1)
        pick2?.setCancelButton(bar2)
        paragraphStyle.alignment = .center
        
        pick2?.pickerTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 17) as Any, NSAttributedStringKey.paragraphStyle: paragraphStyle,NSAttributedStringKey.foregroundColor: UIColor.gray]
        
        pick2?.show()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
      self.tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nachoniltyBtn.isHidden = true
        self.backGround.image = #imageLiteral(resourceName: "bg")
        self.logo.image = #imageLiteral(resourceName: "logo")
        self.password.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.username.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.username.layer.borderWidth = 2
        self.password.layer.borderWidth = 2
        self.passwordConfirmatiob.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.passwordConfirmatiob.layer.borderWidth = 2
        self.email.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.email.layer.borderWidth = 2
        self.mobilenumber.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.mobilenumber.layer.borderWidth = 2
        self.location.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.location.layer.borderWidth = 2
        self.city.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.city.layer.borderWidth = 2
        self.nahionlty.isHidden = true
        self.userIcon.image = #imageLiteral(resourceName: "user")
        self.passicon.image = #imageLiteral(resourceName: "password")
        self.passconIcon.image = #imageLiteral(resourceName: "password")
        self.emailicon.image = #imageLiteral(resourceName: "mail")
        self.mobilenumicon.image = #imageLiteral(resourceName: "mobile")
        self.locationicon.image = #imageLiteral(resourceName: "locationclient")
        self.cityicon.image = #imageLiteral(resourceName: "locationclient")
        self.logo.layer.cornerRadius = 30
        self.logo.clipsToBounds = true
        self.logo.layer.borderWidth = 2.5
        self.logo.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.mobilenumber.keyboardType = .asciiCapableNumberPad
        getCity()
        getNachoniltes()
        self.hideKeyboardWhenTappedAround()
        self.nachonicon.isHidden = true
        if(self.CityNameArray.count == 0){
            self.cityBtn.isEnabled = false
        }
        if(self.nationNameArray.count == 0){
            self.nachoniltyBtn.isEnabled = false
        }
        self.navigationController?.isNavigationBarHidden = false
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named:"bg")!)
    }
    
    func imagePickerController(_ picker:UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]){if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
        let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
        let asset = result.firstObject
        
        }
        let image_data = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageData = UIImagePNGRepresentation((image_data))! as Data
        self.logo.image = image_data
        imageStr = imageData.base64EncodedString()
        self.addNewImage.setImage(nil, for: .normal)
        logo.backgroundColor = UIColor.clear
        
        self.dismiss(animated: true, completion: nil)
        flag4 = true
    }
    
    
    func getCity(){
        params.updateValue(getServerLang(), forKey: "lang")
        
        Alamofire.request(Cities_Url, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                print("😈\(response.result.value)")
                if response.result.value != nil{
                    // print("😈\(response.result.value)")
                    self.cityBtn.isEnabled = true
                    let dataDic = ((response.result.value! as! NSDictionary).value(forKey: "data"))as! [[String: Any]]
                    for dic in dataDic {
                        self.CityArrayID.add(CityModel().getObject(dicc: dic).id)
                        self.CityNameArray.add(CityModel().getObject(dicc: dic).name)
                        
                    }
                    
                }
            case .failure(_):
                print("faild")
                
                print("😭\(response.error)" )
            }
        }
    }
    func getNachoniltes(){
        params.updateValue(getServerLang(), forKey: "lang")
        
        Alamofire.request(Nations_Url, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                print("😈\(response.result.value)")
                if response.result.value != nil{
                    self.nachoniltyBtn.isEnabled = true
                    let dataDic = ((response.result.value! as! NSDictionary).value(forKey: "data"))as! [[String: Any]]
                    for dic in dataDic {
                        self.naationArrayID.add(CityModel().getObject(dicc: dic).id)
                        self.nationNameArray.add(CityModel().getObject(dicc: dic).name)
                        
                    }
                    
                }
            case .failure(_):
                print("faild")
                
                print("😭\(response.error)" )
            }
        }
    }
   

}
extension RegisterFirstStepViewController : sendDataBackDelegate{
    func finishPassing(location: String, lat: Double, lng: Double) {
        self.location.text = location
        
        self.lat = lat
        self.lng = lng
        print("🔓\(self.lat)")
    }
}
