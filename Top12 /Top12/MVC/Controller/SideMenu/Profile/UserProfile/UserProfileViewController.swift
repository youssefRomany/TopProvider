//
//  UserProfileViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 3/23/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SwiftyJSON
import ActionSheetPicker_3_0
import Alamofire

class UserProfileViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon5: UIImageView!
    @IBOutlet weak var icon4: UIImageView!
    @IBOutlet weak var icon3: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    
    @IBOutlet weak var userNAme: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var saveBtn: UIButton!
    
    var user_id = ""
    var currentPassword = ""
    let paragraphStyle = NSMutableParagraphStyle()
      var params:Dictionary = [String:Any]()
    //================
    var citiesName =  [String()]
    var citiiesId = [Int()]
    var city_Id = 1
    ///========
    var CityNameArray = NSMutableArray()
    var CityArrayID = NSMutableArray()
    var CityID = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getProfile()
        getCity()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadImg(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = self.view
        alert.addAction(UIAlertAction(title: "Open camera".localized(), style: .default, handler: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Open photo gallery".localized(), style: .default, handler: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupView(){
        
        if UserDefaults.standard.string(forKey: "client_id") != nil {
            user_id = UserDefaults.standard.string(forKey: "client_id")!
            currentPassword = UserDefaults.standard.string(forKey: "clientPassword")!
        }
        AppUtils.getObject().makeShadow(view: container)
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
       
        self.userImage.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        
        self.userImage.layer.borderWidth = 2
        saveBtn.layer.cornerRadius = saveBtn.frame.height/2
        icon1.image = #imageLiteral(resourceName: "profile2")
        icon2.image = #imageLiteral(resourceName: "password")
        icon3.image = #imageLiteral(resourceName: "mail")
        icon4.image = #imageLiteral(resourceName: "contactus")
        icon5.image = #imageLiteral(resourceName: "city")
        phoneNumber.keyboardType = .phonePad
        self.hideKeyboardWhenTappedAround()
        paragraphStyle.alignment = .center
        
       
    }
    
    
    @IBAction func goBack(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    @IBAction func update(_ sender: Any) {
        if(self.userNAme.text?.isEmpty == true || self.password.text?.isEmpty == true  || self.phoneNumber.text?.isEmpty == true ){
            ShowErrorMassge(massge: "Please complete your data".localized(), title: "")
        }else{
            updateProfile()
        }
        
    }
    @IBAction func openCities(_ sender: Any) {
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
    @objc func actionPickerCancel(){
        
    }
    
    @objc func actionPickerDone(){
        
    }
    
    
    func updateProfile(){
       self.startAnimating()
        let params =  ["user_id" : getUserID(), "name" : self.userNAme.text!,"password" : self.password.text!,  "phone" : self.phoneNumber.text!,"city_id" : city_Id,"email" : self.email.text!, "lang" : Language.currentLanguage()]
            as [String : Any]
        print("🍡\(params)")
        API.POSTImage(url: UpdateProfile_Url, Images: [UIImagePNGRepresentation(userImage.image!)!], Keys: ["avatar"], header: nil, parameters: params, completion: {
            ( succeeded: Bool,  result: [String: AnyObject]) in
            if succeeded {
               self.stopAnimating()
                print("🍡\(result)")
                let status = JSON(result["status"]!).int
                let msg = JSON(result["msg"]!).string
                if status == 1{
                    
                    ShowTrueMassge(massge: "Your profile updated successfully".localized(), title: "")
                }else{
                    ShowErrorMassge(massge: msg!, title: "")
                }
                
            }else{
                self.stopAnimating()
               
            }
        })
        
        
    }
    
    
    
    func getProfile(){
        self.startAnimating()
        
        API.POST(url: Profile_URL, parameters: ["user_id":getUserID(),"lang":getServerLang()], headers: [:]) { (succeeded, result) in
                if succeeded {
                self.stopAnimating()
                
                print("🥥\(result)")
                if result["status"] as! Int == 1{
                    if let data = result["data"] as? [String: Any] {
                        let clientProfile = ClientModel().getObject(dicc: data)
                        self.userNAme.text = clientProfile.name
                        self.phoneNumber.text = clientProfile.phone
                        self.email.text = clientProfile.email
                        self.city.text = clientProfile.city_name
                        self.password.text = self.currentPassword
                        self.city_Id = Int((clientProfile.city_id))!
                        self.userImage.setImageWith(clientProfile.avatar)
                    }
                    
                    
                }else {
                    if let msg = JSON(result)["msg"].string {
                        ShowErrorMassge(massge: msg, title: "")
                        
                    }
                }
                
            }else{
                self.stopAnimating()
                
                
            }
        }
        
        
        
      
    }
    
    func getCity(){
        params.updateValue(getServerLang(), forKey: "lang")
        
        Alamofire.request(Cities_Url, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                print("😈\(response.result.value)")
                if response.result.value != nil{
                    // print("😈\(response.result.value)")
                  //  self.cityBtn.isEnabled = true
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
    
    
}
extension UserProfileViewController :UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // MARK: - Imagepicker methods
    @objc func opengalary() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedimage: UIImage?
        if let editingimage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedimage = editingimage
        }else if let originalimage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedimage = originalimage
        }
        if let selectedim = selectedimage {
            userImage.image = selectedim
        }
        self.stopAnimating()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       self.stopAnimating()
    }
    
    
}
