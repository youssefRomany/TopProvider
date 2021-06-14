//
//  RegisterSecondStepViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.

import UIKit
import SwiftyJSON
import Alamofire
import ActionSheetPicker_3_0

class RegisterSecondStepViewController: UIViewController , AMChoiceDelegate{
  
    @IBOutlet var deleveryPriceTextField: BorderBaddedTextField!
    
    @IBOutlet weak var categoryView: RoundedView!
    @IBOutlet weak var timeTwo: UIImageView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var firstIcon: UIImageView!
    @IBOutlet weak var secondIcon: UIImageView!
    @IBOutlet weak var secondTimeIcon: UIImageView!
    @IBOutlet weak var thirdIcon: UIImageView!
    @IBOutlet weak var profileTwo: UIImageView!
    @IBOutlet weak var choiceTableView: AMChoice!
    @IBOutlet weak var StoreName: BorderBaddedTextField!
    @IBOutlet weak var storeTime: BorderBaddedTextField!
    @IBOutlet weak var storeTimeTwo: BorderBaddedTextField!
    @IBOutlet weak var categories: BorderBaddedTextField!
    @IBOutlet weak var DelgateNumber: BorderBaddedTextField!

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var yesCheack: Checkbox!
    @IBOutlet weak var NoCheackBox: Checkbox!
    @IBOutlet weak var RegisterBtn: RoundedButton!
    let paragraphStyle = NSMutableParagraphStyle()
    let timePicker = UIDatePicker()
    var workat = ""
    var workto = ""
    var isAgree = false
    var selectedImage: UIImage?
    
    let NETWORK = NetworkingHelper()
    let NEW_BILL = "NEW_BILL"

    
    @IBOutlet var agreeCheckBox: Checkbox!
    
 
    
    @IBAction func goback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func RegisterAction(_ sender: Any) {
        
        let selectedItemCommaSeparated = choiceTableView.getSelectedItemsJoined(separator: ",")
       
        if isAgree{
        if(StoreName.text?.isEmpty == true){
                self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                ShowErrorMassge(massge: "You must Complate your Data".localized(), title: "Error".localized())
            }else{
          
                if(self.have_delegate == "1"){
                       print("🌸\(yesCheack.isChecked)")
                    if( StoreName.text?.isEmpty == true || categories.text?.isEmpty == true || self.DelgateNumber.text?.isEmpty == true){
                        self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                        ShowErrorMassge(massge: "You must Complate your Data".localized(), title: "Error".localized())
                    }else{
                        self.startAnimating()
                        imagesData.append(self.imageData!)
                        imagesKeys.append("avatar")
                        self.uplaadImage1(name: self.name, password: self.password, email: self.email, phone: self.phone, city_id: self.cityID, lat: self.lat, lng: self.lang, nationality_id: self.NationltyID, civil_number: self.civil_number, provider_type: self.providerType, shop_name: self.StoreName.text!, have_delegate: self.have_delegate, delegate_number: self.DelgateNumber.text!, delegate_price: "", categories_ids: selectedItemCommaSeparated, person_price: "", minimum_person: "", work_at: workat, work_to: workto)
                    }
                }else{
                    if(self.StoreName.text?.isEmpty == true ){
                        self.RegisterBtn.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                        ShowErrorMassge(massge: "You must Complate your Data".localized(), title: "Error".localized())
                    }else{
                        self.startAnimating()
                        imagesData.append(self.imageData!)
                        
                        imagesKeys.append("avatar")
                        self.uplaadImage1(name: self.name, password: self.password, email: self.email, phone: self.phone, city_id: self.cityID, lat: self.lat, lng: self.lang, nationality_id: self.NationltyID, civil_number: self.civil_number, provider_type: self.providerType, shop_name: self.StoreName.text!, have_delegate: self.have_delegate, delegate_number: "", delegate_price: "" , categories_ids: selectedItemCommaSeparated, person_price: "", minimum_person: "", work_at: workat, work_to: workto)

                    }
                }
            }
        
        }else{
            ShowErrorMassge(massge: "You must accept Terms".localized(), title: "Error".localized())
        }
    }
    
    var index = ""
    var imageStr = ""
    var name = ""
    var password = ""
    var email = ""
    var phone = ""
    var cityID = ""
    var NationltyID = ""
    var civil_number = ""
    var have_delegate = "2"
    var lat = ""
    var lang = ""
    var imageData:Data!
    var imagesData = [Data]()
    var imagesKeys = [String]()
    var params:Dictionary = [String:Any]()
    var CatId = ""
    var  providerType = ""
    let yescheckbox = Checkbox()
    let Nocheckbox = Checkbox()
    var CategotyNameArray = NSMutableArray()
    var CategotyArrayID = NSMutableArray()
    var CategoruModel = [ProviderCategoryModel]()
    
    var CityNameArray = NSMutableArray()
    var CityArrayID = NSMutableArray()
    var CityID = ""
    
    var DelgateFlag = ""
    
    var TimeNameArray = NSMutableArray()
    var TimeArrayID = NSMutableArray()
    var TimeID = ""
    
    @IBAction func openCategoryView(_ sender: Any) {
         self.categoryView.isHidden = false
    }
    
    @IBAction func selectAction(_ sender: Any) {
        self.categoryView.isHidden = true
        // print("😆\(CatId)")
        self.categories.text = choiceTableView.getSelectedItemsTitleJoined(separator: ",")
    }
    
    @IBAction func timeFrom(_ sender: Any) {

//        let datePicker = ActionSheetDatePicker(title: "Start of permanence".localized(), datePickerMode: UIDatePickerMode.time, selectedDate: Date(), doneBlock: {
//            picker, value, index in
//            let formatter = DateFormatter()
//            formatter.dateFormat = "hh:mm a"
//            formatter.locale =  Locale(identifier: "en")
//
//            let localDateString = formatter.string(from: value! as! Date)
//            self.workat = String(describing: localDateString)
//            self.storeTime.text = String(describing: localDateString)
//
//
//            return
//        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!.superview)
//        let secondsInWeek: TimeInterval = 7 * 24 * 60 * 60;
//        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
//        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
//        datePicker?.minuteInterval = 20
//
//        datePicker?.show()
//
 

    }
    
    @IBAction func timeTo(_ sender: Any) {
        
//        let datePicker = ActionSheetDatePicker(title: "End of permanence".localized(), datePickerMode: UIDatePickerMode.time, selectedDate: Date(), doneBlock: {
//            picker, value, index in
//
//
//
//
//            let formatter = DateFormatter()
//            formatter.locale =  Locale(identifier: "en")
//            formatter.dateFormat = "hh:mm a"
//            let localDateString = formatter.string(from: value! as! Date)
//            self.workto = String(describing: localDateString)
//            self.storeTimeTwo.text = String(describing: localDateString)
//
//
//            return
//        }, cancel: { ActionStringCancelBlock in return }, origin: (sender as AnyObject).superview!.superview)
//        let secondsInWeek: TimeInterval = 7 * 24 * 60 * 60;
//        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
//        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
//        datePicker?.minuteInterval = 20
//
//
//
//        datePicker?.show()
        
    }
    @objc func actionPickerCancel(){
        
    }
    
    @objc func actionPickerDone(){
        
    }
    
  @objc  func startTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale =  Locale(identifier: "en")
        self.workat = formatter.string(from: sender.date)
        storeTime.text = formatter.string(from: sender.date)
        timePicker.removeFromSuperview() // if you want to remove time picker
    }
    @objc  func EndTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale =  Locale(identifier: "en")
        self.workto =  formatter.string(from: sender.date)
        storeTimeTwo.text = formatter.string(from: sender.date)
        timePicker.removeFromSuperview() // if you want to remove time picker
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NETWORK.deleget = self
        self.backGroundImage.image = #imageLiteral(resourceName: "bg")
        self.firstIcon.image = #imageLiteral(resourceName: "profile")
        self.profileTwo.image = #imageLiteral(resourceName: "profile")
        self.secondIcon.image = #imageLiteral(resourceName: "time")
        self.timeTwo.image = #imageLiteral(resourceName: "time")
        self.hideKeyboardWhenTappedAround()
        self.tabBarController?.tabBar.isHidden = true
        self.thirdIcon.image = #imageLiteral(resourceName: "mobile")
        self.choiceTableView.selectedImage = #imageLiteral(resourceName: "check_on")
        self.choiceTableView.unselectedImage = #imageLiteral(resourceName: "check_off")
//        self.storeTimeTwo.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        self.storeTimeTwo.layer.borderWidth = 1
        
        
        self.deleveryPriceTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.deleveryPriceTextField.layer.borderWidth = 1
        self.deleveryPriceTextField.placeHolderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.categories.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.categories.layer.borderWidth = 1
        
        
        
        self.DelgateNumber.placeHolderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.DelgateNumber.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.DelgateNumber.layer.borderWidth = 1
        
        
        self.StoreName.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.StoreName.layer.borderWidth = 1
        self.storeTime.placeHolderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
//        self.storeTime.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        self.storeTime.layer.borderWidth = 1
//        self.storeTimeTwo.placeHolderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.agreeCheckBox.borderStyle = .circle
        self.agreeCheckBox.checkmarkStyle = .circle
        self.agreeCheckBox.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        self.agreeCheckBox.borderWidth = 1
        self.agreeCheckBox.checkmarkColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        self.agreeCheckBox.layer.cornerRadius = 11
        
        self.yesCheack.borderStyle = .circle
        self.yesCheack.checkmarkStyle = .circle
        self.yesCheack.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        self.yesCheack.borderWidth = 1
        self.yesCheack.checkmarkColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        self.yesCheack.layer.cornerRadius = 11
        
        self.NoCheackBox.borderStyle = .circle
        self.NoCheackBox.checkmarkStyle = .circle
        self.NoCheackBox.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        self.NoCheackBox.borderWidth = 1
        self.NoCheackBox.checkmarkColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        self.NoCheackBox.layer.cornerRadius = 11
        self.categoryView.isHidden = true
        setupView()
        getCategories()
        getTimes()
        self.thirdIcon.isHidden = true
        self.DelgateNumber.isHidden = true
        
        self.yesCheack.addTarget(self, action: #selector(yesAction(sender:)), for:.valueChanged)
        self.NoCheackBox.addTarget(self, action: #selector(NoAction(sender:)), for:.valueChanged)
        self.agreeCheckBox.addTarget(self, action: #selector(agreeAction(sender:)), for:.valueChanged)

        
        if Language.currentLanguage().contains("en") {
            self.backBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        }else{
            self.backBtn.setImage(#imageLiteral(resourceName: "back-1"), for: .normal)

        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.Nocheckbox.isChecked = true
        
    }
    
    @IBAction func TermisAction(_ sender: Any) {
        let Reg = Storyboard.Main.instantiate(TermsandConftionsViewController.self)
        defaults.set("reg", forKey: TermsFrom)
        self.navigationController?.pushViewController(Reg, animated: true)
    }
    
    @objc func agreeAction(sender: Checkbox){
            self.agreeCheckBox.isChecked = true
        self.isAgree = true
    }
    
    @objc func yesAction(sender: Checkbox){
        if(self.yesCheack.isChecked == true){
            self.NoCheackBox.isChecked = false
            self.NoCheackBox.isEnabled = true
            self.yesCheack.isEnabled = false
             self.DelgateNumber.isHidden = false
            self.thirdIcon.isHidden = false
            self.have_delegate = "1"
        }
    }
    @objc func NoAction(sender: Checkbox){
        if(self.NoCheackBox.isChecked == true){
            self.yesCheack.isChecked = false
            self.yesCheack.isEnabled = true
            self.NoCheackBox.isEnabled = false
            self.DelgateNumber.isHidden = true
            self.thirdIcon.isHidden = true
            self.have_delegate = "2"
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        
        print("item at index \(self.CatId) selected")
    }
    var myItems = [Selectable]()
    
    
    func addtoVoteModel(title: String, isSelected: Bool, isUserSelectEnable: Bool,id:String){
        self.myItems.append(VoteModel(title:title , isSelected: isSelected, isUserSelectEnable: isUserSelectEnable, oilId:id ))
        print("😆\(myItems)")
        setupView()
    }
    func setupView(){
        choiceTableView.isRightToLeft = false // use it to support right to left language
        
        choiceTableView.delegate = self // the delegate used to get the selected item when pressed
        
        choiceTableView.data = myItems  // fill your item , the item may come from server or static in your code like i have done
        
        choiceTableView.selectionType = .multiple // selection type , single or multiple
        
        choiceTableView.cellHeight = 50 // to set cell hight
        
        choiceTableView.arrowImage = nil // use ot if you want to add arrow to the cell
    }
    
    func getCategories(){
        params.updateValue(getServerLang(), forKey: "lang")
        
        Alamofire.request(Category_Url, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                print("😈\(response.result.value)")
                if response.result.value != nil{
                    // print("😈\(response.result.value)")
                    
                    let dataDic = ((response.result.value! as! NSDictionary).value(forKey: "data"))as! [[String: Any]]
                    for dic in dataDic {
                        let cat = ProviderCategoryModel()
                        cat.id = String(describing: dic["id"] as! Int)
                        cat.name = dic["name"] as! String
                        
                        self.CategoruModel.append(cat)
                    }
                    
                    
                    print("🇨🇳\(self.CategoruModel)")
                    for i in self.CategoruModel{
                        self.addtoVoteModel(title:i.name , isSelected: false, isUserSelectEnable: true, id: String(describing: i.id!))
                    }
                    
                    
                    
                    
                }
            case .failure(_):
                print("faild")
                
                print("😭\(response.error)" )
            }
        }
    }
    func getTimes(){
        params.updateValue(getServerLang(), forKey: "lang")
        
        Alamofire.request(ListTime_URL, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                print("😈\(response.result.value)")
                if response.result.value != nil{
                    // print("😈\(response.result.value)")
                 //   self.cityBtn.isEnabled = true
                    let dataDic = ((response.result.value! as! NSDictionary).value(forKey: "data"))as! [[String: Any]]
                    for dic in dataDic {
                        self.TimeArrayID.add(CityModel().getObject(dicc: dic).id)
                        self.TimeNameArray.add(CityModel().getObject(dicc: dic).name)
                        
                    }
                    
                }
            case .failure(_):
                print("faild")
                
                print("😭\(response.error)" )
            }
        }
    }
    
    func uplaadImage(name:String,password:String,email:String,phone:String,city_id:String,lat:String,lng:String,nationality_id:String,civil_number:String,provider_type:String,shop_name:String,have_delegate:String,delegate_number:String,delegate_price:String,categories_ids:String,person_price:String,minimum_person:String,work_at:String,work_to:String){
        var parameters = [String:AnyObject]()
        parameters = [
            "lang":getServerLang(),
            "type":"2",
            "name":name,
            "password":password,
            "phone":phone,
            "city_id":city_id,
            "lat":lat,
            "lng":lng,
            "nationality_id":1,
//            "civil_number":civil_number,
//            "provider_type":provider_type,
            "shop_name":shop_name,
            "have_delegate":have_delegate,
            "delegate_number":delegate_number,
            "categories_ids":categories_ids,
            "work_at":work_at,
            "work_to":work_to
            
            ] as [String : AnyObject]
        
        
        if email != "" {
            
            parameters.updateValue(email as AnyObject, forKey: "email")
        }
        
        if deleveryPriceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            print("donnnnnnnnnnnne")
            parameters.updateValue((deleveryPriceTextField?.text?.replacedArabicDigitsWithEnglish ?? "") as AnyObject, forKey: "fixed_delivery_price")
             }
        print("kokokokok😆\(parameters)")
        API.POSTImage(url: Register_Url, Images: self.imagesData, Keys: imagesKeys, header: nil, parameters: parameters){ (success, value) in
            let json = JSON(value)
            let msg = json["msg"].string
              print("😆\(msg)")
            print("😳\(value)")

            if success{
                self.stopAnimating()
                 let status = value["status"] as? Int
                    if status == 1 {
                        let user_id = json["data"]["user_id"].int
                        let user_code = json["data"]["user_code"].string
                        defaults.set(String(describing: user_id!), forKey: User_ID)
                        ShowTrueMassge(massge: msg!, title: "Succsses".localized())
                        print("🍓\(user_code!)")
                        let Reg = Storyboard.Main.instantiate(VreficationCodeViewController.self)
                        Reg.Code = String(describing: user_code!)
                        defaults.set("reg", forKey: VrefFrom)
                        self.navigationController?.pushViewController(Reg, animated: true)
                    }else{
                        self.stopAnimating()
                      
                        ShowErrorMassge(massge: msg ?? "Error".localized(), title: "Error".localized())
                    }
                
            }else{
                self.stopAnimating()
//                   ShowErrorMassge(massge: msg!, title: "Error")
                let alert = UIAlertController(title: "Connection Error".localized(), message: "Check Your Internet Connection Then Try Again".localized(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss".localized(), style: .default, handler: { (_) in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
    }
    func VrefCode(){
        
        
        
    }
    
}


extension RegisterSecondStepViewController: NetworkingHelperDeleget {
    
    func onHelper(getData data: DataResponse<String>, fromApiName name: String, withIdentifier id: String) {
            handelRegisterResponse(response: data)
    }
    
    func onHelper(getError error: String, fromApiName name: String, withIdentifier id: String) {
        ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
    }
    
    // MARK:- request apis from server
    func uplaadImage1(name:String,password:String,email:String,phone:String,city_id:String,lat:String,lng:String,nationality_id:String,civil_number:String,provider_type:String,shop_name:String,have_delegate:String,delegate_number:String,delegate_price:String,categories_ids:String,person_price:String,minimum_person:String,work_at:String,work_to:String) {
                var parameters = [String:String]()
                parameters = [
                    "lang":getServerLang(),
                    "type":"2",
                    "name":name,
                    "password":password,
                    "phone":phone,
                    "city_id":city_id,
                    "lat":lat,
                    "lng":lng,
                    "nationality_id":"1",
        //            "civil_number":civil_number,
        //            "provider_type":provider_type,
                    "shop_name":shop_name,
                    "have_delegate":have_delegate,
                    "delegate_number":delegate_number,
                    "categories_ids":categories_ids,
                    "work_at":work_at,
                    "work_to":work_to
                    
                    ] as [String : String]
                
                
                if email != "" {
                    
                    parameters.updateValue(email as String, forKey: "email")
                }
                
                if deleveryPriceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
                    print("donnnnnnnnnnnne")
                    parameters.updateValue((deleveryPriceTextField?.text?.replacedArabicDigitsWithEnglish ?? "") as String, forKey: "fixed_delivery_price")
                     }
                print("kokokokok😆\(parameters)")

        print(params, GET_BILLS )
        if let image = selectedImage{
            NETWORK.connectToUploadObject(toApi: Register_Url, withParameters: parameters, andIdentifier: "rrrrr", images: ["avatar":image ])
        }
    }
    
    // MARK:- handle response server
        func handelRegisterResponse(response: DataResponse<String>){
            self.stopAnimating()

        switch response.response?.statusCode {
        case 200:
            print("success")
              do{
                let resp = try JSONDecoder().decode(RegisterResponse.self, from: response.data ?? Data())
                let msg = resp.msg ?? ""

                if resp.status == 1{
                    let user_id = resp.data?.user_id ?? 0
                    let user_code = resp.data?.user_code ?? ""
                    defaults.set(String(describing: user_id), forKey: User_ID)
                    ShowTrueMassge(massge: msg, title: "Succsses".localized())
                    let Reg = Storyboard.Main.instantiate(VreficationCodeViewController.self)
                    Reg.Code = String(describing: user_code)
                    defaults.set("reg", forKey: VrefFrom)
                    self.navigationController?.pushViewController(Reg, animated: true)

                }else{
                      self.stopAnimating()
                    
                    ShowErrorMassge(massge: msg , title: "Error".localized())

                }

                
            }catch let error{
                print(error,"mina")
                ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
            }

        default:
            ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
        }
    }
    
    
    // MARK:- handle response server

}


struct RegisterResponse : Codable {
    let status : Double?
    let msg : String?
    let notification : Int?
    let data : DataRegister?
}

struct DataRegister : Codable {
    let user_id : Int?
    let user_code : String?
}
