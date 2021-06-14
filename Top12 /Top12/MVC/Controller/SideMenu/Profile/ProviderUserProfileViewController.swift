//
//  ProviderUserProfileViewController.swift
//  Ayadena
//
//  Created by Sara Ashraf on 10/22/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON
import ActionSheetPicker_3_0
import Photos

class ProviderUserProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var uploadImage: UIButton!
    var imagesData = [Data]()
    var imagesKeys = [String]()
    var params:Dictionary = [String:Any]()
    let textViewRecognizer = UITapGestureRecognizer()
    var utils = AppUtils.getObject()
    var flag1 = false
    var flag2 = false
    var flag4 = false
    var flag5 = false
    var imageStr = ""
    var imageData:Data!
    var CityNameArray = NSMutableArray()
    var CityArrayID = NSMutableArray()
    var CityID = ""
    var nationId = ""
    var nationNameArray = NSMutableArray()
    var naationArrayID = NSMutableArray()
    var NationID = ""
    var AreaNameArray = NSMutableArray()
    var AreaArrayID = NSMutableArray()
    var AreaID = ""
    var newLat : Double = 0.0
    var newLng : Double = 0.0
    var lat:Double!
    var lng:Double!
    func didSelectAddrress(lat: Double, lng: Double, add: String) {
        if lat != nil{
            
            newLat = lat
            newLng  = lng
            
            self.Location.text! = add
            print("💃map successss\(newLat)")
        }
    }
    
    static var UserLat = UserDefaults.standard.float(forKey: User_Lat)
    static var UserLng = UserDefaults.standard.float(forKey: User_Lng)
    
    let UserName: SkyFloatingLabelTextFieldWithIcon = {
        let Txtf = SkyFloatingLabelTextFieldWithIcon()
        Txtf.iconType = .image
        Txtf.placeholder = "User Name".localized()
        Txtf.title = "User Name".localized()
        Txtf.font = UIFont(name: "Cairo-Regular", size: 14)
        Txtf.iconWidth = 25
        Txtf.textColor = UIColor.gray
       // Txtf.iconImage = UIImage(imageLiteralResourceName: "user")
        Txtf.selectedTitleColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedLineHeight = 2
        Txtf.selectedLineColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedIconColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.iconFont = UIFont(name: "Cairo-Regular", size: 15)
        Txtf.lineHeight = 1
        
        
        return Txtf
        
    }()
    
    let mobileNumberText: SkyFloatingLabelTextFieldWithIcon = {
        let Txtf = SkyFloatingLabelTextFieldWithIcon()
        Txtf.iconType = .image
        Txtf.placeholder = "Mobile Number".localized()
        Txtf.title = "Mobile Number".localized()
        Txtf.font = UIFont(name: "Cairo-Regular", size: 14)
        Txtf.iconWidth = 25
        Txtf.textColor = UIColor.gray
       // Txtf.iconImage = UIImage(imageLiteralResourceName: "mobile")
        Txtf.selectedTitleColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedLineHeight = 2
        Txtf.selectedLineColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedIconColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.iconFont = UIFont(name: "Cairo-Regular", size: 15)
        Txtf.lineHeight = 1
        Txtf.keyboardType = .phonePad
        
        return Txtf
        
    }()
    
   
    let Email: SkyFloatingLabelTextFieldWithIcon = {
        let Txtf = SkyFloatingLabelTextFieldWithIcon()
        Txtf.iconType = .image
        Txtf.placeholder = "Email".localized()
        Txtf.title = "Email".localized()
        Txtf.font = UIFont(name: "Cairo-Regular", size: 14)
        Txtf.iconWidth = 25
        Txtf.textColor = UIColor.gray
       // Txtf.iconImage = UIImage(imageLiteralResourceName: "mail")
        Txtf.selectedTitleColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedLineHeight = 2
        Txtf.selectedLineColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedIconColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.iconFont = UIFont(name: "Cairo-Regular", size: 15)
        Txtf.lineHeight = 1
        
        
        return Txtf
        
    }()
    let Nationality: SkyFloatingLabelTextFieldWithIcon = {
        let Txtf = SkyFloatingLabelTextFieldWithIcon()
        Txtf.iconType = .image
        Txtf.placeholder = "Nationality".localized()
        Txtf.title = "Nationality".localized()
        Txtf.font = UIFont(name: "Cairo-Regular", size: 14)
        Txtf.iconWidth = 25
        Txtf.textColor = UIColor.gray
        //Txtf.iconImage = UIImage(imageLiteralResourceName: "profile")
        Txtf.selectedTitleColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedLineHeight = 2
        Txtf.selectedLineColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedIconColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.iconFont = UIFont(name: "Cairo-Regular", size: 15)
        Txtf.lineHeight = 1
        
        
        return Txtf
        
    }()
    
    
    let NachoniltyBtn: UIButton = {
        let Btn = UIButton()
        Btn.backgroundColor = UIColor.clear
        Btn.isEnabled = true
        Btn.addTarget(self, action: #selector(NachoniltyAction), for: .touchUpInside)
        
        return Btn
    }()
    
    let City: SkyFloatingLabelTextFieldWithIcon = {
        let Txtf = SkyFloatingLabelTextFieldWithIcon()
        Txtf.iconType = .image
        Txtf.placeholder = "City".localized()
        Txtf.title = "City".localized()
        Txtf.font = UIFont(name: "Cairo-Regular", size: 14)
        Txtf.iconWidth = 25
        Txtf.textColor = UIColor.gray
      //  Txtf.iconImage = UIImage(imageLiteralResourceName: "city")
        Txtf.selectedTitleColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedLineHeight = 2
        Txtf.selectedLineColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedIconColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.iconFont = UIFont(name: "Cairo-Regular", size: 15)
        Txtf.lineHeight = 1
        
        
        return Txtf
        
    }()
    
    
    let Location: SkyFloatingLabelTextFieldWithIcon = {
        let Txtf = SkyFloatingLabelTextFieldWithIcon()
        Txtf.iconType = .image
        Txtf.placeholder = "Location".localized()
        Txtf.title = "Location".localized()
        Txtf.font = UIFont(name: "Cairo-Regular", size: 14)
        Txtf.iconWidth = 25
        Txtf.textColor = UIColor.gray
      //  Txtf.iconImage = UIImage(imageLiteralResourceName: "city")
        Txtf.selectedTitleColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedLineHeight = 2
        Txtf.selectedLineColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedIconColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.lineHeight = 1
        
        
        return Txtf
        
    }()
    let Password: SkyFloatingLabelTextFieldWithIcon = {
        let Txtf = SkyFloatingLabelTextFieldWithIcon()
        Txtf.iconType = .image
        Txtf.placeholder = "Password".localized()
        Txtf.title = "Password".localized()
        Txtf.font = UIFont(name: "Cairo-Regular", size: 14)
        Txtf.iconWidth = 25
        Txtf.textColor = UIColor.gray
     //   Txtf.iconImage = UIImage(imageLiteralResourceName: "")
        Txtf.selectedTitleColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedLineHeight = 2
        Txtf.selectedLineColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.selectedIconColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Txtf.lineHeight = 1
        Txtf.isSecureTextEntry = true
        
        return Txtf
        
    }()
    
    let CityBtn: UIButton = {
        let Btn = UIButton()
        Btn.backgroundColor = UIColor.clear
        Btn.isEnabled = true
        
        Btn.addTarget(self, action: #selector(CityAction), for: .touchUpInside)
        
        return Btn
    }()
    
    let container:UIScrollView = {
        let frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width
            , height:UIScreen.main.bounds.height)
        let scroll = UIScrollView(frame: frame)
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = true
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: ((UIScreen.main.bounds.height) + 170))
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor.clear
        return scroll
    }()
    
    
    let RegisterBtn: UIButton = {
        let Btn = UIButton()
        Btn.setTitle("Save".localized(), for: .normal)
        Btn.tintColor = UIColor.white
        Btn.backgroundColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        Btn.titleLabel?.textColor = UIColor.white
        Btn.isEnabled = true
        Btn.setTitleColor( UIColor.white, for: .normal)
        Btn.titleLabel?.font = UIFont(name: "Cairo-Regular", size: 16)
        Btn.addTarget(self, action: #selector(addNewUser), for: .touchUpInside)
        
        return Btn
    }()
    
    let LocationBtn: UIButton = {
        let Btn = UIButton()
        Btn.backgroundColor = UIColor.clear
        Btn.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
        
        return Btn
    }()
    
    @objc func getLocation(){
        let Reg = Storyboard.Main.instantiate(GetLocationViewController.self)
        Reg.delegate = self
        self.navigationController?.pushViewController(Reg, animated: true)
    }
    
    func imagePickerController(_ picker:UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]){if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
        let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
        let asset = result.firstObject
        
        }
        let image_data = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageData = UIImagePNGRepresentation((image_data))! as Data
        self.imageLogo.image = image_data
        imageStr = imageData.base64EncodedString()
        imageLogo.backgroundColor = UIColor.clear
        self.dismiss(animated: true, completion: nil)
        flag4 = true
    }
    
    @objc func addNewUser(){
        
      
            if(flag4 == false){
                imagesData = []
                imagesKeys = []
            }else{
                imagesData.append(self.imageData!)
                imagesKeys.append("avatar")
                
                
            }
            self.startAnimating()
            self.uplaadImage(name: self.UserName.text!, password: self.Password.text!, email: self.Email.text!, phone: self.mobileNumberText.text!, city_id: self.CityID, lat:String(describing: self.lat!), lng: String(describing: self.lng!), nationality_id: self.NationID, civil_number: "")
        
    }
    @objc func AreaData(sender:UIButton){
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstrin()
        ButtonDesign()
        getNachoniltes()
        getCity()
        self.NachoniltyBtn.isEnabled = false
        self.Nationality.isUserInteractionEnabled = false
        self.City.isUserInteractionEnabled = false
        self.CityBtn.isEnabled = false
        self.hideKeyboardWhenTappedAround()
        self.imageLogo.layer.cornerRadius = 120/2
        self.imageLogo.clipsToBounds = true
        self.imageLogo.layer.borderWidth = 2.5
        self.imageLogo.layer.borderColor = #colorLiteral(red: 0.3255335987, green: 0.7335553765, blue: 0.6398102641, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = ""
       
        self.startAnimating()
        getProfileData()
    }
    
    let paragraphStyle = NSMutableParagraphStyle()
    
    @objc func CityAction(sender:UIButton){
        
        let pick2 = ActionSheetStringPicker(title: "Select your City".localized(), rows: self.CityNameArray as! [String], initialSelection: 0, doneBlock: {
            picker, indexes, values in
            print(indexes)
            print(values!)
            
            self.City.text = values as? String
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
    @objc func NachoniltyAction(sender:UIButton){
        
        let pick2 = ActionSheetStringPicker(title: "Select your Nationilty".localized(), rows: self.nationNameArray as! [String], initialSelection: 0, doneBlock: {
            picker, indexes, values in
            print(indexes)
            print(values!)
            
            //   self.City.text = values as? String
            // self.countryCode.setTitle(values as? String, for: .normal)
            
            self.Nationality.text = values as? String
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
    
    
    
    
    @objc func actionPickerDone(){
        
    }
    
    func makeConstrin(){
        
        self.view.addSubview(container)
        
        container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        container.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.container.addSubview(imageLogo)
        imageLogo.snp.makeConstraints{
            (make) in
            make.top.equalTo(self.container.snp.top).offset(70)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        self.container.addSubview(uploadImage)
        uploadImage.snp.makeConstraints{
            (make) in
            make.top.equalTo(self.container.snp.top).offset(70)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        self.container.addSubview(UserName)
        UserName.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(imageLogo.snp.bottom).offset(20)
        }
        
        self.container.addSubview(mobileNumberText)
        mobileNumberText.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(UserName.snp.bottom).offset(3)
            
        }
         self.container.addSubview(Email)
        Email.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(mobileNumberText.snp.bottom).offset(3)
            
        }
        self.container.addSubview(Nationality)
        Nationality.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(Email.snp.bottom).offset(3)
            
        }
        
        
        self.container.addSubview(NachoniltyBtn)
        NachoniltyBtn.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(Email.snp.bottom).offset(3)
            
        }
       
        self.container.addSubview(City)
        City.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(Nationality.snp.bottom).offset(3)
            
        }
        
        self.container.addSubview(CityBtn)
        CityBtn.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(City.snp.top).offset(0)
            
        }
        self.container.addSubview(Location)
        Location.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(City.snp.bottom).offset(3)
            
        }
        
        self.container.addSubview(LocationBtn)
        LocationBtn.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(City.snp.bottom).offset(3)
            
        }
        self.container.addSubview(Password)
        Password.snp.makeConstraints{
            (make) in
            make.width.equalTo(textFiledWidth)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(Location.snp.bottom).offset(3)
        }
        
        
        
        
        self.container.addSubview(RegisterBtn)
        RegisterBtn.snp.makeConstraints{
            (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.Password.snp.bottom).offset(10)
            make.width.equalTo((getScreenWidth()/1.3))
            make.height.equalTo(50)
        }
        
    }
    
    @IBAction func uploadImageAction(_ sender: Any) {
        print("😃🔍hiiiiii")
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: false, completion: nil)
    }
    
    func ButtonDesign(){
        self.RegisterBtn.layer.cornerRadius = 15
        RegisterBtn.layer.shadowColor = UIColor.lightGray.cgColor
        RegisterBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        RegisterBtn.layer.shadowRadius = 5
        RegisterBtn.layer.shadowOpacity = 1.0
        
        
    }
    
    ////==========>>> Get City
    
    
    func getCity(){
        params.updateValue(getServerLang(), forKey: "lang")
     
        
        Alamofire.request(Cities_Url, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                print("😇\(response.result.value)")
                if response.result.value != nil{
                    // print("😈\(response.result.value)")
                    self.City.isUserInteractionEnabled = false
                    self.CityBtn.isEnabled = true
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
                    // print("😈\(response.result.value)")
                    self.NachoniltyBtn.isEnabled = true
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
    
    
    
    
    
    func uplaadImage(name:String,password:String,email:String,phone:String,city_id:String,lat:String,lng:String,nationality_id:String,civil_number:String){
        var parameters = [String:AnyObject]()
        print(UpdateProfile_Url, "rrrrrrrrrrr")
        parameters = [
            "lang":getServerLang(),
            "user_id":getUserID(),
            "name":name,
            "email":email,
            "phone":phone,
            "city_id":city_id,
            "lat":lat,
            "lng":lng,
            "nationality_id":nationality_id,
            "civil_number":civil_number,
            "address": self.Location.text ?? ""
            ] as [String : AnyObject]
        // 26.487895072314373 37.04883631970972
        print(parameters)
        if(Password.text?.isEmpty == false){
            parameters.updateValue(self.Password.text! as AnyObject , forKey: "password")
        
        }
        API.POSTImage(url: UpdateProfile_Url, Images: imagesData , Keys: imagesKeys, header: nil, parameters: parameters){ (success, value) in
            if success{
                self.stopAnimating()
                  print("💰\(parameters)")
                if let status = value["status"] as? Int{
                    if status == 1 {
                        print("💰\(value)")
                        let msg = value["msg"] as! String
                        let data = value["data"] as! [String:Any]
                        let name =  data["name"] as? String
                        defaults.set(name, forKey: User_Name)
                        
                        ShowTrueMassge(massge: msg, title: "".localized())
                        
                        
                    }else{
                        self.stopAnimating()
                        let alert = UIAlertController(title: "Connection Error".localized(), message: "Check Your Internet Connection Then Try Again".localized(), preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss".localized(), style: .default, handler: { (_) in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }else{
                self.stopAnimating()
                let alert = UIAlertController(title: "Connection Error".localized(), message: "Check Your Internet Connection Then Try Again".localized(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss".localized(), style: .default, handler: { (_) in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
        
    }
    
   
    func getProfileData(){
        let params: Parameters = [
            "lang":getServerLang(),
            "user_id":getUserID()
        ]
        Alamofire.request(Profile_URL, method: .post, parameters:params, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let status = json["status"].int
                let msg = json["msg"].string
                self.stopAnimating()
                   print("😈\(json)")
                if(status == 1){
                  
                    let name = json["data"]["name"].stringValue
                    let email = json["data"]["email"].stringValue
                    let phone = json["data"]["phone"].stringValue
                    let city_name = json["data"]["city_name"].stringValue
                    let nationality_name = json["data"]["nationality_name"].stringValue
                    let avatar = json["data"]["avatar"].stringValue
                    let civil_number = json["data"]["civil_number"].stringValue
                    let city_id = json["data"]["city_id"].int!
                    let nationality_id = json["data"]["nationality_id"].int!
                    let lat = json["data"]["lat"].stringValue
                    let lng = json["data"]["lng"].stringValue
                    self.lat = Double(lat)
                    self.lng = Double(lng)
                    self.CityID = String(describing: city_id)
                    self.NationID = String(describing: nationality_id)
                    self.UserName.text = name
                    self.Email.text = email
                    self.mobileNumberText.text = phone
                    self.City.text = city_name
                    self.Nationality.text = nationality_name
                 //   self.Location.text =
                    self.imageLogo.setImageWith(avatar)
                    defaults.set(avatar, forKey: User_Avatar)
                }else{
                    self.stopAnimating()
                    ShowErrorMassge(massge: msg!, title: "")
                }
                
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
            }
        }
        
    }
    
}
extension ProviderUserProfileViewController : sendDataBackDelegate{
    func finishPassing(location: String, lat: Double, lng: Double) {
        self.Location.text = location
        
        self.lat = lat
        self.lng = lng
        print("🔓\(self.lat!)")
    }
}

