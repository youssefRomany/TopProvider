//
//  StoreProfileViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/23/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.


import UIKit
import Alamofire
import SwiftyJSON


class StoreProfileViewController: UIViewController,AMChoiceDelegate {
    
    @IBOutlet weak var DelgateNumber: BorderBaddedTextField!
    @IBOutlet weak var profileIcon: UIImageView!
    @IBOutlet weak var storeName: BorderBaddedTextField!
    @IBOutlet weak var secondICon: UIImageView!
    @IBOutlet weak var secondView: RoundedView!
    @IBOutlet weak var choiseTableView: AMChoice!
    
    @IBOutlet weak var CategoryProfile: UIImageView!
    @IBOutlet weak var categories: BorderBaddedTextField!
    @IBOutlet weak var choiceTableView: AMChoice!
    @IBOutlet weak var yesCheack: Checkbox!
    @IBOutlet weak var NoCheackBox: Checkbox!
    @IBOutlet weak var saveChange: RoundedButton!
    
    @IBOutlet var DeliveryCostTextField: BorderBaddedTextField!
    @IBOutlet var costView: UIView!
    @IBOutlet var attentionView: UIView!
    
    
    var CategNameArray = NSMutableArray()
    var CategArrayID = NSMutableArray()
    var CategID = ""
    var params:Dictionary = [String:Any]()
    var DelgateFlag = ""
    var CategoruModel = [ProviderCategoryModel]()
    var selectedItemCommaSeparated = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.secondView.isHidden = true
        self.DelgateNumber.layer.cornerRadius = 25
        self.DelgateNumber.layer.borderColor = UIColor.gray.cgColor
        self.DelgateNumber.layer.borderWidth = 1
        self.hideKeyboardWhenTappedAround()
        
        self.DeliveryCostTextField.layer.cornerRadius = 25
        self.DeliveryCostTextField.layer.borderColor = UIColor.gray.cgColor
        self.DeliveryCostTextField.layer.borderWidth = 1

        self.storeName.layer.cornerRadius = 25
        self.storeName.layer.borderColor = UIColor.gray.cgColor
        self.storeName.layer.borderWidth = 1
        
        self.categories.layer.cornerRadius = 25
        self.categories.layer.borderColor = UIColor.gray.cgColor
        self.categories.layer.borderWidth = 1
        self.NoCheackBox.layer.cornerRadius = 22/2
        self.yesCheack.layer.cornerRadius = 22/2
        self.profileIcon.image = #imageLiteral(resourceName: "profile2")
        self.secondICon.image = #imageLiteral(resourceName: "profile2")
        self.CategoryProfile.image = #imageLiteral(resourceName: "profile2")
        
        self.yesCheack.borderStyle = .circle
        self.yesCheack.checkmarkStyle = .circle
        self.yesCheack.checkedBorderColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.yesCheack.checkmarkColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.yesCheack.uncheckedBorderColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.yesCheack.borderColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.yesCheack.borderWidth = 1
        self.yesCheack.borderColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        
        self.NoCheackBox.borderStyle = .circle
        self.NoCheackBox.checkmarkStyle = .circle
        self.NoCheackBox.checkedBorderColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.NoCheackBox.checkmarkColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.NoCheackBox.uncheckedBorderColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.NoCheackBox.borderColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.NoCheackBox.borderWidth = 1
        self.NoCheackBox.borderColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.choiseTableView.selectedImage = #imageLiteral(resourceName: "check_on")
        self.choiseTableView.unselectedImage = #imageLiteral(resourceName: "check_off")
        
        getCategories()
        setupView()
        self.yesCheack.addTarget(self, action: #selector(yesAction(sender:)), for:.valueChanged)
        self.NoCheackBox.addTarget(self, action: #selector(NoAction(sender:)), for:.valueChanged)
    }
    @objc func yesAction(sender: Checkbox){
        if(self.yesCheack.isChecked == true){
            self.NoCheackBox.isChecked = false
            self.NoCheackBox.isEnabled = true
            self.DelgateNumber.isHidden = false
            self.secondICon.isHidden = false
            self.DeliveryCostTextField.isHidden = false
            self.costView.isHidden = false
            self.attentionView.isHidden = false
            
            self.DelgateFlag = "1"
        }
    }
    @objc func NoAction(sender: Checkbox){
        if(self.NoCheackBox.isChecked == true){
            self.yesCheack.isChecked = false
            self.yesCheack.isEnabled = true
            self.DelgateNumber.isHidden = true
            self.secondICon.isHidden = true
            self.DelgateFlag = "0"
            self.DelgateNumber.text = ""
            self.DeliveryCostTextField.isHidden = true
            self.costView.isHidden = true
            self.attentionView.isHidden = true
            self.DeliveryCostTextField.text = ""

        }
    }
    
    @IBAction func selectCategory(_ sender: Any) {
        self.secondView.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.startAnimating()
        self.getShopData(user_id: getUserID())
    }
    
    @IBAction func saveAction(_ sender: Any) {
        // || DelgateNumber.text?.isEmpty == true
        if(storeName.text?.isEmpty == true || categories.text?.isEmpty == true  ){
            
            ShowErrorMassge(massge: "You must Complate your Data".localized(), title: "".localized())
        }else{
            var fff = self.selectedItemCommaSeparated
            self.selectedItemCommaSeparated = choiseTableView.getSelectedItemsJoined(separator: ",")
            if selectedItemCommaSeparated == ""{
                let str = fff.substring(to: fff.index(before: fff.endIndex))
                selectedItemCommaSeparated = str
            }
            print("🌸\(selectedItemCommaSeparated)")
            self.startAnimating()
            self.EditShop(shop_name: self.storeName.text!, categories_ids:selectedItemCommaSeparated, have_delegate: self.DelgateFlag, delegate_number: self.DelgateNumber.text! )
        }
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
    func setupView(){
        choiseTableView.isRightToLeft = false
        choiseTableView.delegate = self
        choiseTableView.data = myItems
        choiseTableView.selectionType = .multiple
        choiseTableView.cellHeight = 50
        choiseTableView.arrowImage = nil 
    }
    func didSelectRowAt(indexPath: IndexPath) {
        print("item at index \(indexPath.row) selected")
        
    }
    
    func EditShop(shop_name:String,categories_ids:String,have_delegate:String,delegate_number:String){
        var params:Parameters = [
            "user_id":getUserID(),
            "shop_name":shop_name,
            "categories_ids":categories_ids,
            "lang":getServerLang(),
            "have_delegate":have_delegate,
            "delegate_number":delegate_number
        ]
        
        if DeliveryCostTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            print("donnnnnnnnnnnne")
            params.updateValue((DeliveryCostTextField?.text?.replacedArabicDigitsWithEnglish ?? "") as AnyObject, forKey: "fixed_delivery_price")
             }
        
        print("😆\(params) mmmmmmdmdmdmdmdmdmmrmrmrm")
        API.POST(url: UpdateShop_URL, parameters: params, headers: nil) { (success, value) in
            if success{
                let status = value["status"] as? Int
                let msg = value["msg"] as? String
                print("😆\(value)")
                if (status == 1){
                    self.stopAnimating()
                    ShowTrueMassge(massge: "Modified successfully".localized(), title: "".localized())
                    self.navigationController?.popViewController(animated: true)
                    
                }else{
                    self.stopAnimating()
                    ShowErrorMassge(massge: msg ??  "You must Complate your Data".localized(), title: "".localized())
                }
            }
        }
    }
    
    @IBAction func selectAction(_ sender: Any) {
        self.secondView.isHidden = true
        // print("😆\(CatId)")
        self.categories.text = choiseTableView.getSelectedItemsTitleJoined(separator: " ")
    }
    var myItems = [Selectable]()
    
    func addtoVoteModel(title: String, isSelected: Bool, isUserSelectEnable: Bool,id:String){
        self.myItems.append(VoteModel(title:title , isSelected: isSelected, isUserSelectEnable: isUserSelectEnable, oilId:id ))
        print("😆\(myItems)")
        setupView()
    }
    
    func getShopData(user_id:String){
        
        let url = ShopData_Url
        let params: Parameters = [
            
            "user_id": user_id,
            "lang":getServerLang()
        ]
        API.POST(url: url, parameters: params, headers: [:]) { (success, value) in
            if success{
                self.stopAnimating()
                let data = value["data"] as! [String:Any]
                let shop_name = data["shop_name"] as! String
                let shop_delegate_phone = data["shop_delegate_phone"] as! String
                let shop_have_delegate = data["shop_have_delegate"] as! String
                let user_image = data["user_image"] as! String
                let user_name = data["user_name"] as! String
                let deliveryPrice = data["fixed_delivery_price"] as? Int ?? 0
                defaults.set(user_image, forKey: User_Avatar)
                defaults.set(user_name, forKey: User_Name)
                var SubCategories = [UserCategoriesModel]()
                
                self.DelgateNumber.text! = shop_delegate_phone
                self.storeName.text! = shop_name
                self.DeliveryCostTextField.text = deliveryPrice != 0 ? "\(deliveryPrice)" : ""
                
                if(shop_have_delegate == "yes"){
                    self.yesCheack.isChecked = true
                    self.NoCheackBox.isChecked = false
                    self.DelgateFlag = "1"
                    self.DelgateNumber.isHidden = false
                    self.secondICon.isHidden = false
                    self.DeliveryCostTextField.isHidden = false
                    self.costView.isHidden = false
                    self.attentionView.isHidden = false


                }else{
                    self.DelgateFlag = "0"
                    self.yesCheack.isChecked = false
                    self.NoCheackBox.isChecked = true
                    self.DelgateNumber.isHidden = true
                    self.secondICon.isHidden = true
                    self.DeliveryCostTextField.isHidden = true
                    self.costView.isHidden = true
                    self.attentionView.isHidden = true
                    self.DeliveryCostTextField.text = ""


                }
                let subCatg = data["user_categories"] as! [[String:Any]]
                SubCategories = []
                for i in 0..<subCatg.count{
                    let subcatModel = UserCategoriesModel()
                    self.selectedItemCommaSeparated += "\(subCatg[i]["category_id"] as! Int),"
                    print("\(subCatg[i]["category_id"] as! Int),",self.selectedItemCommaSeparated, "rrrrrrrrr")
                    subcatModel.category_id = subCatg[i]["category_id"] as! Int
                    subcatModel.category_name = subCatg[i]["category_name"] as! String
                    self.categories.text = self.categories.text! + " - " + subcatModel.category_name!
                    
                    
                    SubCategories.append(subcatModel)
                    
                    
                }
                
                
            }
        }
        
    }
    
}



