//
//  EditProductViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/17/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import OpalImagePicker
import Alamofire
import SwiftyJSON
import SnapKit
import Kingfisher
import Photos
import ActionSheetPicker_3_0

class EditProductViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate ,UICollectionViewDataSource{
    @IBOutlet weak var selectCatg: BorderBaddedTextField!
    @IBOutlet weak var nameAr: UITextField!
    @IBOutlet weak var addNewItem: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var disc: UITextField!
    @IBOutlet weak var addProduct: UIButton!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var numberOfPerson: BorderBaddedTextField!
    @IBOutlet weak var orderTime: BorderBaddedTextField!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var addtionNotes: UITextField!
    
    var additions = [proudctAddtionsOrderModel]()
    var CategotyNameArray = NSMutableArray()
    var CategotyArrayID = NSMutableArray()
    var CategID = ""
    var params:Dictionary = [String:Any]()
    var index = ""
    var NewAddtions = [AddetionsModel]()
    var imagesData = [Data]()
    var imagesKeys = [String]()
    var imagesArray:[UIImage] = []
    var imagesDataSourse = [ProductImages]()
    var flag1 = false
    var flag2 = false
    var flag4 = false
    var flag5 = false
    var imageStr = ""
    var imageData:Data!
    var productID = ""
    var nameArbic = ""
    var nameEnglish = ""
    var price = ""
    var descrip = ""
    let paragraphStyle = NSMutableParagraphStyle()
    var TimesNameArray = NSMutableArray()
    var TimesArrayID = NSMutableArray()
    var TimeID = ""
    var DeltedImageID = ""
    
    @IBOutlet var instantCheckBox: Checkbox!
    @IBOutlet var priorCheckBox: Checkbox!
    var newTimeArray: [String] = []

    var order_type = "instant"
    var isInstant = true

    
    @IBAction func addNeaImage(_ sender: Any) {
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 5
        imagePicker.selectionTintColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 0.3999625428)
        present(imagePicker, animated: true, completion: nil)
    }
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentHight: NSLayoutConstraint!
    var Addtions = [String]()
    @IBAction func addNew(_ sender: Any) {
        // self.NewAddtions.append("")
        self.NewAddtions.append(AddetionsModel(name_en : "", price: "0", name_ar: ""))
        self.contentHight.constant += 100.0
        self.tableViewHeight.constant += 100.0
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.NewAddtions.count
    }
    
    @IBAction func getTimeBtnAction(_ sender: Any) {
             print("😠\(self.TimesNameArray)")
            let pick2 = ActionSheetStringPicker(title: "This product takes".localized(), rows: self.newTimeArray , initialSelection: 0, doneBlock: {
                picker, indexes, values in
                print(indexes)
                print(values!)
                self.orderTime.text = values as? String
    //            self.TimeID = self.TimesArrayID[indexes] as! String
                print("😠\(self.CategID)")
                return
            }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
            let bar1 = UIBarButtonItem.init(title: "Done".localized(), style: .plain, target: self, action: #selector(actionPickerDone))
            let bar2 = UIBarButtonItem.init(title: "Cancel".localized(), style: .plain, target: self, action: #selector(actionPickerDone))
            bar1.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16) as Any, NSAttributedStringKey.foregroundColor:#colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)], for: .normal)
            bar2.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)], for: .normal)
            pick2?.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16) as Any ,NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)]
            pick2?.setDoneButton(bar1)
            pick2?.setCancelButton(bar2)
            paragraphStyle.alignment = .center
            pick2?.pickerTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16) as Any, NSAttributedStringKey.paragraphStyle: paragraphStyle,NSAttributedStringKey.foregroundColor: UIColor.gray]
            pick2?.show()
        }
    
    func getTimes(){
        params.updateValue(getServerLang(), forKey: "lang")
        
        Alamofire.request(ListTime_URL, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                print("😈\(response.result.value)")
                //   self.addNewTime.isEnabled = true
                if response.result.value != nil{
                    let dataDic = ((response.result.value! as! NSDictionary).value(forKey: "data"))as! [[String: Any]]
                    for dic in dataDic {
                        self.TimesArrayID.add(TimeModel().getObject(dicc: dic).id)
                        self.TimesNameArray.add(TimeModel().getObject(dicc: dic).name)
                        
                    }
                    
                }
            case .failure(_):
                print("faild")
                print("😭\(response.error)" )
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProductTableViewCell", for: indexPath) as! EditProductTableViewCell
        if (self.NewAddtions.count != 0){
            cell.name_ar.text = self.NewAddtions[indexPath.row].name_ar
            cell.countTextFaild.text = self.NewAddtions[indexPath.row].price
            cell.count = Int(self.NewAddtions[indexPath.row].price)!
            
        }
        
        cell.addition = self.NewAddtions[indexPath.row]
        cell.countTextFaild.tag = indexPath.row
        cell.countTextFaild.addTarget(self, action: #selector(savePrice(_:)), for: .editingChanged)
        
        cell.name_ar.tag = indexPath.row
        cell.name_ar.addTarget(self, action: #selector(saveNameAr(_:)), for: .editingChanged)
        
        cell.minsBtn.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
        cell.minsBtn.tag = indexPath.row
        cell.minsBtn.addTarget(self, action: #selector(deleteAddtions), for: .touchUpInside)
        cell.detectCount = {
            self.NewAddtions[indexPath.row].price = cell.countTextFaild.text!
        }
        return cell
    }
    
    @objc func deleteAddtions(buttonTag:UIButton){
        print("🤔\(buttonTag.tag)")
        self.NewAddtions.remove(at: buttonTag.tag)
        if(self.NewAddtions.count == 0){
        }
        self.contentHight.constant -= 90
        self.tableViewHeight.constant -= 90
        self.tableView.reloadData()
    }
    
    @objc func savePrice(_ tf : UITextField){
        print("🙁\(tf.text!)")
        self.NewAddtions[tf.tag].price = (tf.text != nil || tf.text?.count != 0 ? tf.text! : "")
    }
    @objc func saveNameAr(_ tf : UITextField){
        self.NewAddtions[tf.tag].name_ar = (tf.text != nil || tf.text?.count != 0 ? tf.text! : "")
        
    }
    
    func configureMenuTableView(){
        tableView.register(UINib(nibName: "EditProductTableViewCell", bundle: nil), forCellReuseIdentifier: "EditProductTableViewCell")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }
    @IBAction func EditProductAction(_ sender: Any) {
        self.EditProduct()
    }
    
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        self.imagesArray.append(images) 
        presentedViewController?.dismiss(animated: true, completion: nil)
        self.collectionView.reloadData()
        print("💙💙\(images)")
        for i in images{
            self.imagesData.append( UIImagePNGRepresentation((i))! as Data)
            print("😆\(imagesData)")
            imagesKeys.append("images[]")
        }
        flag1 = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuTableView()
        self.numberOfPerson.keyboardType = .asciiCapableNumberPad
        self.productPrice.keyboardType = .asciiCapableNumberPad

        self.disc.layer.cornerRadius = 20
        self.addtionNotes.layer.cornerRadius = 20
        self.addImage.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        self.dropdownarrow.image = #imageLiteral(resourceName: "dropdownm")
        self.addNewItem.setImage(#imageLiteral(resourceName: "newadd"), for: .normal)
        self.navigationItem.title = "Edit Product".localized()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        print("🌻\(self.productID)")
        self.startAnimating()
        self.ShowProduct(user_id: getUserID(), product_id: self.productID)
        self.editBtn.isEnabled = false
        self.getCategories()
        self.getTimes()
        cheackBoxStyel()
        self.instantCheckBox.layer.cornerRadius = 10
        self.priorCheckBox.layer.cornerRadius = 10
        self.priorCheckBox.addTarget(self, action:  #selector(FamlyCheack(sender:)), for: .valueChanged)
        self.hideKeyboardWhenTappedAround()
        self.instantCheckBox.addTarget(self, action:  #selector(OtherCheack(sender:)), for: .valueChanged)

    }
    
            @objc func FamlyCheack(sender: Checkbox){
                self.orderTime.text = ""
                self.instantCheckBox.isChecked = false
                
                self.priorCheckBox.isEnabled = false
                self.instantCheckBox.isEnabled = true
                
                self.order_type = "prior"
    //            self.priorNameArray = self.TimesNameArray
    //            self.priorArrayID = self.TimesArrayID
                
                self.newTimeArray = ["ثلاث ساعات","اربع ساعات","يوم","يومان","ثلاثة ايام"]

            }
            @objc func OtherCheack(sender: Checkbox){
                self.orderTime.text = ""
                self.newTimeArray = ["نصف ساعة","ساعة","ساعةونصف"]
                self.priorCheckBox.isChecked = false
                self.priorCheckBox.isEnabled = true
                self.instantCheckBox.isEnabled = false
                
                self.order_type = "instant"


            }
            
            func cheackBoxStyel(){
                instantCheckBox.borderStyle = .circle
                instantCheckBox.checkmarkColor = UIColor.white
                instantCheckBox.checkmarkStyle = .circle
                instantCheckBox.checkmarkColor =  #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
                instantCheckBox.uncheckedBorderColor = UIColor.gray
                instantCheckBox.borderWidth = 2
                instantCheckBox.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
                instantCheckBox.checkedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
                
                
                priorCheckBox.borderStyle = .circle
                priorCheckBox.checkmarkColor = UIColor.white
                priorCheckBox.checkmarkStyle = .circle
                priorCheckBox.checkmarkColor =  #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
                priorCheckBox.uncheckedBorderColor = UIColor.gray
                priorCheckBox.borderWidth = 2
                priorCheckBox.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
                priorCheckBox.checkedBorderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
            }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBOutlet weak var dropdownarrow: UIImageView!
    @IBAction func selectActvity(_ sender: Any) {
        let pick2 = ActionSheetStringPicker(title: "Select Product Category".localized(), rows: self.CategotyNameArray as! [String], initialSelection: 0, doneBlock: {
            picker, indexes, values in
            print(indexes)
            print(values!)
            self.selectCatg.text = values as? String
            self.CategID = self.CategotyArrayID[indexes] as! String
            print("😠\(self.CategID)")
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        let bar1 = UIBarButtonItem.init(title: "Done".localized(), style: .plain, target: self, action: #selector(actionPickerDone))
        let bar2 = UIBarButtonItem.init(title: "Cancel".localized(), style: .plain, target: self, action: #selector(actionPickerDone))
        bar1.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 18) as Any, NSAttributedStringKey.foregroundColor:#colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)], for: .normal)
        bar2.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 18) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)], for: .normal)
        pick2?.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 18) as Any ,NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)]
        pick2?.setDoneButton(bar1)
        pick2?.setCancelButton(bar2)
        paragraphStyle.alignment = .center
        pick2?.pickerTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 17) as Any, NSAttributedStringKey.paragraphStyle: paragraphStyle,NSAttributedStringKey.foregroundColor: UIColor.gray]
        pick2?.show()
    }
    
    @objc func actionPickerDone(){
        
    }
}
extension EditProductViewController: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }
    
    //    }
    
    func imagePickerNumberOfExternalItems(_ picker: OpalImagePickerController) -> Int {
        return 1
    }
    
    func imagePickerTitleForExternalItems(_ picker: OpalImagePickerController) -> String {
        return NSLocalizedString("External", comment: "External (title for UISegmentedControl)")
    }
    
    func imagePicker(_ picker: OpalImagePickerController, imageURLforExternalItemAtIndex index: Int) -> URL? {
        return URL(string: "https://placeimg.com/500/500/nature")
    }
    ////////==========>>>>
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! imageCollectionViewCell
        // cell.prodImage.setImageWith(self.imagesDataSourse[indexPath.row].image_path!)
        cell.prodImage.image = self.imagesArray[indexPath.row]
        cell.deleteImage.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
        //  cell.deleteImage.tag = self.imagesDataSourse[indexPath.row].image_id!
        cell.toogleAction = {
            self.imagesArray.remove(at: indexPath.row)
            self.DeltedImageID += String(describing: self.imagesDataSourse[indexPath.row].image_id!) + ","
            print("😆\(self.DeltedImageID)")
            if(self.imagesArray.count == 0){
                self.imagesData.removeAll()
                //self.addImage.isHidden = false
                
            }else{
                
            }
            self.collectionView.reloadData()
        }
        cell.deleteImage.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        cell.prodImage.layer.cornerRadius = 15
        cell.prodImage.clipsToBounds = true
        
        return cell
    }
    
    
    
    @objc func deleteImage(buttonTag:UIButton){
        print("🤔\(buttonTag.tag)")
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imagesArray.count
    }
    func ShowProduct(user_id:String,product_id:String){
        let url = ShopDetils_Url
        let params: Parameters = [
            "user_id": user_id,
            "product_id":product_id,
            "lang":getServerLang()
        ]
        API.POST(url: url, parameters: params, headers: nil) { (success, value) in
            if success{
                
                print("🌹\(value)")
                let data = value["data"] as! [String:Any]
                let product_name = data["product_name"] as! String
                let product_price = data["product_price"] as! String
                let product_disc = data["product_disc"] as! String
                let product_time = data["product_time"] as! String
                let product_enough_to = data["product_enough_to"] as! String
                let TypeOfOrder = data["order_type"] as! String

                
                let product_category_name = data["product_category_name"] as! String
                let product_shop_name = data["product_shop_name"] as! String
                let product_main_image = data["product_main_image"] as! String
                let product_category_id = data["product_category_id"] as! Int
                let product_images = data["product_images"] as! [[String:Any]]
                let product_additions = data["product_additions"] as! [[String:Any]]
                let product_extra_info = data["product_extra_info"] as! String
                
                for pa in product_additions{
                    let addition_id = pa["id"] as! Int
                    let addition_name = pa["name_ar"] as! String
                    let addition_price = pa["price"] as! String
                    self.additions.append(proudctAddtionsOrderModel(addition_id: addition_id, addition_name: addition_name, addition_price: Int(addition_price), addition_count: 0))
                    self.NewAddtions.append(AddetionsModel(name_en:addition_name,price:addition_price,name_ar:addition_name))
                }
                for im in product_images{
                    let image_id = im["image_id"] as! Int
                    let image_path = im["image_path"] as! String
                    self.imagesDataSourse.append(ProductImages(image_id: image_id, image_path: image_path))
                    
                    let url = URL(string:image_path)
                    if let data = try? Data(contentsOf: url!)
                    {
                        let image: UIImage = UIImage(data: data)!
                        self.imagesArray.append(image)
                    }
                }
                self.CategID = String(product_category_id)
                self.collectionView.reloadData()
                self.tableView.reloadData()
                self.contentHight.constant += CGFloat(90 * self.NewAddtions.count)
                self.tableViewHeight.constant += CGFloat(90 * self.NewAddtions.count)
                self.productPrice.text = product_price
                self.nameAr.text = product_name
                self.selectCatg.text = product_category_name
                self.orderTime.text = product_time
                self.numberOfPerson.text = product_enough_to
                self.disc.text = product_disc
                self.addtionNotes.text  = product_extra_info
                if TypeOfOrder == "instant"{
                    self.newTimeArray = ["نصف ساعة","ساعة","ساعةونصف"]

                    self.priorCheckBox.isChecked = false
                    self.instantCheckBox.isChecked = true
                    self.priorCheckBox.isEnabled = true
                    self.instantCheckBox.isEnabled = false
                    
                    self.order_type = "instant"

                }else{
                                self.instantCheckBox.isChecked = false
                                
                                self.priorCheckBox.isEnabled = false
                                self.instantCheckBox.isEnabled = true
                                
                                self.order_type = "prior"
                    //            self.priorNameArray = self.TimesNameArray
                    //            self.priorArrayID = self.TimesArrayID
                                
                                self.newTimeArray = ["ثلاث ساعات","اربع ساعات","يوم","يومان","ثلاثة ايام"]

                }
                
                self.stopAnimating()
            }
        }
    }
    func getCategories(){
        params.updateValue(getServerLang(), forKey: "lang")
        params.updateValue(getUserID(), forKey: "user_id")
        Alamofire.request(MyCategory, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                self.editBtn.isEnabled = true
                if response.result.value != nil{
                    let dataDic = ((response.result.value! as! NSDictionary).value(forKey: "data"))as! [[String: Any]]
                    for dic in dataDic {
                        self.CategotyArrayID.add(ProviderCategoryModel().getObject(dicc: dic).id)
                        self.CategotyNameArray.add(ProviderCategoryModel().getObject(dicc: dic).name)
                        print("😈\(self.CategotyNameArray)")
                    }
                    
                }
            case .failure(_):
                print("faild")
                print("😭\(response.error)" )
            }
        }
    }
    
    func EditProduct(){
        
        if(selectCatg.text?.isEmpty == true || nameAr.text?.isEmpty == true ||  disc.text?.isEmpty == true || numberOfPerson.text?.isEmpty == true || orderTime.text?.isEmpty == true || productPrice.text?.isEmpty == true){
            self.addProduct.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "Please Complete Your data".localized(), title: "Eror".localized())
        }else{
            var additionJson = [[String:Any]]()
            
            for item in self.NewAddtions{
                additionJson.append(item.toDic())
            }
            let activitesData = try? JSONSerialization.data(withJSONObject: additionJson, options: .prettyPrinted)
            let activitiesDataJson = String(data: activitesData!, encoding: String.Encoding.utf8)
            print("✏️\(activitiesDataJson)")
            self.startAnimating()
            let  parameters = [
                "lang":getServerLang(),
                "user_id":getUserID(),
                "product_id":self.productID,
                "name_ar":self.nameAr.text!,
                "order_type":self.order_type,
                "disc":self.disc.text!,
                "category_id":self.CategID,
                "additions":activitiesDataJson,
                "price":self.productPrice.text!,
                "time":self.orderTime.text!,
                "enough_to":self.numberOfPerson.text!,
                "extra_info" : self.addtionNotes.text!,
                "delete_image_ids":self.DeltedImageID
                
                ] as [String : AnyObject]
            
            print(parameters, "kkkkkkkkk")
            API.POSTImage(url: EditProduct_Url, Images: imagesData , Keys: imagesKeys, header: nil, parameters: parameters){ (success, value) in
                if success{
                    print("👌🏻\(self.imagesData)")
                    self.stopAnimating()
                    let msg = value["msg"] as! String
                    if let status = value["status"] as? Int{
                        if status == 1 {
                            ShowTrueMassge(massge: msg, title: "Succsses".localized())
                            guard let window = UIApplication.shared.keyWindow else { return }
                            
                            var vc = MyTabBAr()
                            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyTabBAr") as! MyTabBAr
                            vc.selectedIndex = 2 
                            window.rootViewController = vc
                            
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
        
        
    }
    
}

