//
//  AddnewProductViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/15/19.
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

class AddnewProductViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate ,UICollectionViewDataSource{
    @IBOutlet weak var selectCatg: BorderBaddedTextField!
    @IBOutlet weak var addNewTime: UIButton!
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
    @IBOutlet weak var AddtionNotes: UITextField!
    @IBOutlet weak var CategoryBtn: UIButton!

    @IBOutlet var instantCheckBox: Checkbox!
    @IBOutlet var priorCheckBox: Checkbox!
    
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentHight: NSLayoutConstraint!

    var order_type = "instant"
    var isInstant = true
    
     var selectedimage: UIImage?
    let paragraphStyle = NSMutableParagraphStyle()
    var params:Dictionary = [String:Any]()
    var index = ""
    var NewAddtions = [AddetionsModel]()
    var imagesData = [Data]()
    var imagesKeys = [String]()
    var imagesArray:[UIImage] = []
    var flag1 = true
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
    var CategNameArray = NSMutableArray()
    var CategArrayID = NSMutableArray()
    var CategID = ""
    
    var TimesNameArray = NSMutableArray()
    var TimesArrayID = NSMutableArray()
    
    var instantNameArray = NSMutableArray()
    var instantArrayID = NSMutableArray()
    
    var priorNameArray = NSMutableArray()
    var priorArrayID = NSMutableArray()

    
    var newTimeArray: [String] = []
    var selectedTimes: [Int] = []

    var TimeID = ""
    var flagAddtions = false
    
    
    
    @IBAction func addProductAction(_ sender: Any) {
        self.addNewPRoduct()
    }
    
    @IBAction func selectTime(_ sender: Any) {
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
    
    @IBAction func addNeaImage(_ sender: Any) {

               
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = self.view

        alert.addAction(UIAlertAction(title: "Open camera".localized(), style: .default, handler: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            if UIDevice.current.userInterfaceIdiom == .pad {
                    imagePicker.allowsEditing = false
                } else {
                    imagePicker.allowsEditing = true
                }
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Open photo gallery".localized(), style: .default, handler: { _ in
            let imagePicker = OpalImagePickerController()
            imagePicker.imagePickerDelegate = self
            
            imagePicker.maximumSelectionsAllowed = 5
            imagePicker.selectionTintColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 0.3999625428)
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
//        alert.present(self, animated: true, completion: nil)
        if let popoverController = alert.popoverPresentationController {
                      popoverController.sourceView = self.view
                      popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                      popoverController.permittedArrowDirections = []
                }
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    var Addtions = [String]()
    @IBAction func addNew(_ sender: Any) {
        self.NewAddtions.append(AddetionsModel(name_en:"", price: "0", name_ar : ""))
        self.contentHight.constant += 100.0
        self.tableViewHeight.constant += 100.0
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.NewAddtions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProductTableViewCell", for: indexPath) as! EditProductTableViewCell
        cell.addition = self.NewAddtions[indexPath.row]
        cell.countTextFaild.tag = indexPath.row
        cell.countTextFaild.addTarget(self, action: #selector(savePrice(_:)), for: .editingChanged)
        cell.name_ar.placeholder = "Special Additions".localized()
        cell.name_ar.tag = indexPath.row
        cell.name_ar.addTarget(self, action: #selector(saveNameAr(_:)), for: .editingChanged)
        
//        cell.minsBtn.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
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
        self.NewAddtions[tf.tag].price = (tf.text != nil || tf.text?.count != 0 ? tf.text! : "")
    }
    
    
    @objc func saveNameAr(_ tf : UITextField){
        self.NewAddtions[tf.tag].name_ar = (tf.text != nil || tf.text?.count != 0 ? tf.text! : "")
        self.NewAddtions[tf.tag].name_en = (tf.text != nil || tf.text?.count != 0 ? tf.text! : "")
    }
    
    func configureMenuTableView(){
        tableView.register(UINib(nibName: "EditProductTableViewCell", bundle: nil), forCellReuseIdentifier: "EditProductTableViewCell")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        self.imagesArray = images
        
        
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
        
        self.newTimeArray = ["نصف ساعة","ساعة","ساعة و نصف","ثلاث ساعات","اربع ساعات"]

        
        configureMenuTableView()
        self.priorCheckBox.isChecked = false
        self.instantCheckBox.isChecked = true
        self.priorCheckBox.isEnabled = true
        self.instantCheckBox.isEnabled = false
        
        self.productPrice.keyboardType = .asciiCapableNumberPad

        
        self.order_type = "instant"

        
        self.NewAddtions.append(AddetionsModel(name_en:"", price: "0", name_ar : ""))
        self.contentHight.constant += 100.0
        self.tableViewHeight.constant += 100.0
        self.tableView.reloadData()
        
        
        self.disc.layer.cornerRadius = 20
        self.AddtionNotes.layer.cornerRadius = 20
        self.numberOfPerson.placeholder = "This product is enough for 5 people".localized()
        self.orderTime.placeholder = "This request takes 3 hours".localized()
        
        self.numberOfPerson.keyboardType = .asciiCapableNumberPad
        self.productPrice.keyboardType = .asciiCapableNumberPad
        

        self.addImage.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        self.dropdownarrow.image = #imageLiteral(resourceName: "dropdownm")
        self.addNewItem.setImage(#imageLiteral(resourceName: "newadd"), for: .normal)
        self.navigationItem.title = "Add new Product".localized()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        self.CategoryBtn.isEnabled = false
         self.addNewTime.isEnabled = false
        
        self.hideKeyboardWhenTappedAround()
        getTimes()
        getCategories()
        
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
            
            self.TimesNameArray = self.priorNameArray
            self.TimesArrayID = self.priorArrayID
            self.newTimeArray = ["يوم","يومان","ثلاثة ايام","اربعة ايام","خمسة ايام"]
            
        }
    
        @objc func OtherCheack(sender: Checkbox){
            self.orderTime.text = ""
            self.newTimeArray = ["نصف ساعة","ساعة","ساعة و نصف","ثلاث ساعات","اربع ساعات"]

            self.priorCheckBox.isChecked = false
            self.priorCheckBox.isEnabled = true
            self.instantCheckBox.isEnabled = false
            self.order_type = "instant"
            
            self.TimesNameArray = self.instantNameArray
            self.TimesArrayID = self.instantArrayID


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
        let pick2 = ActionSheetStringPicker(title: "Select Product Category".localized(), rows: self.CategNameArray as! [String], initialSelection: 0, doneBlock: {
            picker, indexes, values in
            print(indexes)
            print(values!)
            self.selectCatg.text = values as? String
            self.CategID = self.CategArrayID[indexes] as! String
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
    
    
}
extension AddnewProductViewController: OpalImagePickerControllerDelegate {
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
        cell.prodImage.image = self.imagesArray[indexPath.row]
        cell.deleteImage.addTarget(self, action: #selector(deleteImage), for: .touchUpInside)
        cell.deleteImage.tag = indexPath.row
        cell.deleteImage.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        cell.prodImage.layer.cornerRadius = 15
        cell.prodImage.clipsToBounds = true
        self.addImage.isHidden = true
        
        return cell
    }
    @objc func deleteImage(buttonTag:UIButton){
        print("🤔\(buttonTag.tag)")
        self.imagesArray.remove(at: buttonTag.tag)
         print("🤔\(self.imagesArray)")
        if(self.imagesArray.count == 0){
            
            self.addImage.isHidden = false
            
        }
        self.collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imagesArray.count
    }
    
    func getCategories(){
        params.updateValue(getServerLang(), forKey: "lang")
        params.updateValue(getUserID(),forKey:"user_id")
        Alamofire.request(MyCategory, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                self.CategoryBtn.isEnabled = true
                 print("😈\(response.result.value)")
                if response.result.value != nil{
                    let dataDic = ((response.result.value! as! NSDictionary).value(forKey: "data"))as! [[String: Any]]
                    for dic in dataDic {
                        self.CategArrayID.add(ProviderCategoryModel().getObject(dicc: dic).id)
                        self.CategNameArray.add(ProviderCategoryModel().getObject(dicc: dic).name)
                        print("😈\(self.CategNameArray)")
                    }
                    
                }
            case .failure(_):
                print("faild")
                print("😭\(response.error)" )
            }
        }
    }
    @objc func actionPickerDone(){
        
    }
    
    
    
    func getTimes(){
        params.updateValue(getServerLang(), forKey: "lang")
        
        Alamofire.request(ListTime_URL, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                  print("😈\(response.result.value)")
               self.addNewTime.isEnabled = true
                if response.result.value != nil{
                    let dataDic = ((response.result.value! as! NSDictionary).value(forKey: "data"))as! [[String: Any]]
                    for dic in dataDic {
                        self.TimesArrayID.add(TimeModel().getObject(dicc: dic).id)
                        self.TimesNameArray.add(TimeModel().getObject(dicc: dic).name)
                    }
                    
                    self.instantNameArray = self.TimesNameArray
                    self.instantArrayID = self.TimesArrayID

                }
            case .failure(_):
                print("faild")
                print("😭\(response.error)" )
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editingimage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            self.selectedimage = editingimage
        }else if let originalimage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.selectedimage = originalimage
        }
        dismiss(animated:true, completion: nil)
        self.imagesArray.append(self.selectedimage!)
       
        self.imagesData.append( UIImagePNGRepresentation((selectedimage!))! as Data)
        print("😆\(imagesData)")
        imagesKeys.append("images[]")
         flag1 = true
         self.collectionView.reloadData()
       
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.stopAnimating()
    }
    
    func addNewPRoduct(){
        var s = [[String:Any]]()
        
        for item in self.NewAddtions{
            s.append(item.toDic())
            if(item.name_ar == ""){
                flagAddtions = false
                self.addProduct.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
                ShowErrorMassge(massge: "Please Complete Your data".localized(), title: "Eror".localized())
            }else{
                flagAddtions = true
            }
            
        }
        if(self.NewAddtions.count == 0){
            flagAddtions = true
        }
        print("😠\(self.NewAddtions.count)")
        if(selectCatg.text?.isEmpty == true || nameAr.text?.isEmpty == true ||  disc.text?.isEmpty == true || numberOfPerson.text?.isEmpty == true || flag1 == false || orderTime.text?.isEmpty == true || productPrice.text?.isEmpty == true || flagAddtions == false){
            self.addProduct.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
            ShowErrorMassge(massge: "Please Complete Your data".localized(), title: "Eror".localized())
            
        
           
            
            
            
        }else{
            var s = [[String:Any]]()
            for item in self.NewAddtions{
                s.append(item.toDic())
            }
            let activitesData = try? JSONSerialization.data(withJSONObject: s, options: .prettyPrinted)
            let activitiesDataJson = String(data: activitesData!, encoding: String.Encoding.utf8)
            self.startAnimating()
            var  parameters = [
                "lang":getServerLang(),
                "user_id":getUserID(),
                "product_id":self.productID,
                "name_ar":self.nameAr.text!,
                "name en":self.nameAr.text!,
                "order_type":self.order_type,
                "disc":self.disc.text!,
                "category_id":self.CategID,
                "price":self.productPrice.text!,
                "time":self.orderTime.text!,
                "enough_to":self.numberOfPerson.text!,
                "extra_info":self.AddtionNotes.text!
                
                ] as [String : AnyObject]
            
            
            if NewAddtions.count != 0 {
                if !(NewAddtions.count == 1 && NewAddtions[0].name_ar == ""){
                    parameters.updateValue(activitiesDataJson as AnyObject, forKey: "additions")

                }
            }
            
            API.POSTImage(url: AddProduct_Url, Images: imagesData , Keys: imagesKeys, header: nil, parameters: parameters){ (success, value) in
                if success{
                    print("👌🏻\(parameters)")
                     print("🍉\(value)")
                    self.stopAnimating()
                    let msg = value["msg"] as! String
                    if let status = value["status"] as? Int{
                        if status == 1 {
                            ShowTrueMassge(massge: msg, title: "Succsses".localized())
                            self.goToHome()
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
    func goToHome(){
        guard let window = UIApplication.shared.keyWindow else { return }
        var vc = MyTabBAr()
        vc = Storyboard.Main.instantiate(MyTabBAr.self)
        window.rootViewController = vc
    }
    
    
}
