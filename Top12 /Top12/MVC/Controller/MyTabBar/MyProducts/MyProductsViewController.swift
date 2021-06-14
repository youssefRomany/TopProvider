//
//  MyProductsViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import SideMenu
import ActionSheetPicker_3_0

class MyProductsViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet var switchButton: UISwitch!
    
    
    
    var ProductDataSource = [productsModel]()
    let paragraphStyle = NSMutableParagraphStyle()
    var selectableItem = ""
    var selectedIndex = 0
    var shopId = 0
    var isOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "My Products".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .done, target: self, action: #selector(openChat))
         self.menuBtn.image = #imageLiteral(resourceName: "menu")
        
        /// init table view
            tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
            tableView.estimatedRowHeight = 100
            
    }
    
    @objc func openChat(){
        print("hiii")
        let Reg = Storyboard.Main.instantiate(ClientMessagesViewController.self)
        self.navigationController?.pushViewController(Reg, animated: true)
    }
    
    @IBAction func CLOSEOROPENSTOREACTION(_ sender: Any) {
        openStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.ProductDataSource = []
        self.tableView.reloadData()
        self.startAnimating()
        self.getAllProduct(user_id: getUserID())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.ProductDataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1 // self.ProductDataSource.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
//        cell.productImage.setImageWith(self.ProductDataSource[indexPath.section].product_main_image)
//        cell.productName.text = self.ProductDataSource[indexPath.section].product_name
//        cell.productDisc.text = self.ProductDataSource[indexPath.section].product_disc
//        cell.productPrice.text = "Price".localized() + " : " + self.ProductDataSource[indexPath.section].product_price! + " " + "SR".localized()
//        cell.menuEditBtn.isHidden = true
       // cell.menuEditBtn.addTarget(self, action: #selector(moreMenu), for: .touchUpInside)
        //cell.menuEditBtn.tag = self.ProductDataSource[indexPath.section].product_id!
        print("🌕\(self.ProductDataSource[indexPath.row].product_id!)")
//        cell.productImage.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
//        cell.productImage.layer.borderWidth = 1
//        cell.selectionStyle = .none
//        cell.layer.cornerRadius = 30
//        cell.clipsToBounds  = true
        cell.configureCell(withProductsModel: self.ProductDataSource[indexPath.row], andParent: self, withIndex: indexPath.row)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Home = Storyboard.Main.instantiate(ProudctDetilsViewController.self)
        Home.proudctID = String(describing: self.ProductDataSource[indexPath.row].product_id!)
       // Home.CatgId = String(describing: self.ProductDataSource[indexPath.section].ca!)
        self.navigationController?.pushViewController(Home, animated: false)
    }
    
    
    @IBAction func openMenu(_ sender: Any) {
        if(getServerLang() == "en"){
            let sideMenuVc = Storyboard.Main.instantiate(ProviderSideMenuViewController.self)
            let menuNavgtion = UISideMenuNavigationController(rootViewController: sideMenuVc)
            SideMenuManager.default.menuAddPanGestureToPresent(toView: (self.navigationController?.navigationBar)!)
            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView:(self.navigationController?.navigationBar)! )
            SideMenuManager.default.menuFadeStatusBar = false
            SideMenuManager.default.menuPresentMode = .viewSlideInOut
            SideMenuManager.default.menuShadowOpacity = 0.5
            SideMenuManager.default.menuAnimationBackgroundColor =  UIColor(patternImage: UIImage(named: "sideMenubg")!)
            SideMenuManager.default.menuLeftNavigationController = menuNavgtion
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else{
            let sideMenuVc = Storyboard.Main.instantiate(ProviderSideMenuViewController.self)
            let menuNavgtion = UISideMenuNavigationController(rootViewController: sideMenuVc)
            SideMenuManager.default.menuAddPanGestureToPresent(toView: (self.navigationController?.navigationBar)!)
            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView:(self.navigationController?.navigationBar)! )
            SideMenuManager.default.menuFadeStatusBar = false
            SideMenuManager.default.menuPresentMode = .viewSlideInOut
            SideMenuManager.default.menuShadowOpacity = 0.5
            SideMenuManager.default.menuAnimationBackgroundColor =  UIColor(patternImage: UIImage(named: "sideMenubg")!)
            SideMenuManager.default.menuRightNavigationController = menuNavgtion
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
    }
    
    @objc func moreMenu (sender:UIButton) {
        let productId = sender.tag
        paragraphStyle.alignment = .center
        
        let pick2 = ActionSheetStringPicker(title: "", rows: ["Edit".localized(),"Delete".localized()], initialSelection: 1, doneBlock: {
            picker, indexes, values in
            print(indexes)
            print(values!)
            
            self.selectableItem = (values as? String)!
            if(self.selectableItem == "Add offer".localized()){
                print("hiiiiiii")
                
            }
            if(self.selectableItem == "Delete".localized()){
                self.startAnimating()
                self.DeleteOffer(product_id: productId)
            }
            if(self.selectableItem == "Edit".localized()){
             //   defaults.set("edit", forKey: UpdateOrAdd)
                let forgetPass = Storyboard.Main.instantiate(EditProductViewController.self)
                 forgetPass.productID = String(sender.tag)
//                forgetPass.nameArbic = self.nameAr
//                forgetPass.nameEnglish = self.nameEn
//                forgetPass.price = self.productPrice
//                forgetPass.descrip = self.disc
//                forgetPass.productID = self.proudctID
//                forgetPass.index = self.CatgId
                self.navigationController?.pushViewController(forgetPass, animated: true)
            }
            
            
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        let bar1 = UIBarButtonItem.init(title: "Done".localized(), style: .plain, target: self, action: #selector(actionPickerCancel))
        let bar2 = UIBarButtonItem.init(title: "Cancel".localized(), style: .plain, target: self, action: #selector(actionPickerCancel))
        
        bar1.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 20) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)], for: .normal)
        bar2.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 20) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)], for: .normal)
        
        
        
        pick2?.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular" , size: 20) as Any, NSAttributedStringKey.foregroundColor: UIColorFromRGB(rgbValue: 0x493D30)]
        
        pick2?.setDoneButton(bar1)
        pick2?.setCancelButton(bar2)
        
        pick2?.pickerTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 17) as Any, NSAttributedStringKey.paragraphStyle: paragraphStyle]
        pick2?.show()
        
        
    }
    @objc func actionPickerCancel(){
        
    }
    
    
    func getAllProduct(user_id:String){
        let params:Parameters = [
            "user_id":user_id
        ]
        API.POST(url: ShopData_Url, parameters: params, headers: nil) { (succss, value) in
            if succss{
                print("☘️\(value)")
                self.stopAnimating()
                let status = value["status"] as! Int

                if(status == 1){
                    
                
                let data = value["data"] as! [String:Any]
                    self.shopId = data["shop_id"] as? Int ?? 0
                    self.isOpen = data["shop_open"] as! Bool
                    print("isOpen", self.isOpen)
                    self.switchButton.setOn(self.isOpen, animated: true)
                    

                let products = data["products"] as! [[String:Any]]
                for i in products{
                    let product_id = i["product_id"] as! Int
                    let product_name = i["product_name"] as! String
                    let product_price = i["product_price"] as! String
                    let product_disc = i["product_disc"] as! String
                    let product_have_offer = i["product_have_offer"] as! Bool
                    let product_order_count = i["product_order_count"] as! Int
                    let product_offer_price = i["product_offer_price"] as! Int
                    let product_main_image = i["product_main_image"] as! String
                    let product_type = i["product_type"] as! String
                    let is_active = i["is_active"] as! Bool
                    
                    self.ProductDataSource.append(productsModel(product_id: product_id, product_order_count: product_order_count, product_name: product_name, product_price: product_price, product_have_offer: product_have_offer, product_disc: product_disc, product_main_image: product_main_image, product_offer_price: product_offer_price,is_active: is_active, product_type: product_type))
                    
                }
                }else{
                    self.stopAnimating()
                    let msg = value["msg"] as! String
                    ShowErrorMassge(massge: msg, title: "Error".localized())
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // change 2 to desired number of
                        let Reg = Storyboard.Main.instantiate(LoginViewController.self)
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(Reg, animated: true)
                    }
                }
                self.tableView.reloadData()
            }else{
                self.stopAnimating()
            }
        }
    }
    
    func DeleteOffer(product_id:Int){
        let params: Parameters = [
            "user_id": getUserID(),
            "product_id":product_id,
            "lang":getServerLang()
        ]
        Alamofire.request(DeleteOffer_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let status = json["status"].int
                let msg = json["msg"].string
                print("😋\(response)")
                print("😁\(params)")
                self.stopAnimating()
                if(status == 1){
                    ShowTrueMassge(massge: "Product successfully Deleted".localized(), title: "success".localized())
                }else{
                    ShowErrorMassge(massge: msg!, title: "Error".localized())
                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
        }
        
    }
    
 //   https://top12app.com/api/product/toggle_active?lang=ar&product_id=295&user_id=510
    func activeProduct(product_id:Int){
        startAnimating()
        let params: Parameters = [
            "user_id": getUserID(),
            "product_id":product_id,
            "language":getServerLang()
        ]
        
        Alamofire.request(TOGGLE_ACTIVE, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let status = json["status"].int ?? 1
                let msg = json["message"].stringValue
                print("😋\(response)")
                print("😁\(status)")
                self.stopAnimating()
                if(status == 0){
                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
                }else{
                    self.ProductDataSource[self.selectedIndex].is_active = !(self.ProductDataSource[self.selectedIndex].is_active ?? false)
                    ShowTrueMassge(massge: msg , title: "success".localized())

                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
            self.tableView.reloadData()
            self.stopAnimating()
        }
        
    }
    
    // https://top12app.com/api/toggle_open?language=ar&shop_id=183
    func openStore(){
        startAnimating()
        let params: Parameters = [
            "user_id": getUserID(),
            "shop_id": shopId,
            "language":getServerLang()
        ]
        
        Alamofire.request(TOGGLE_OPEN, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let status = json["status"].int ?? 1
                let msg = json["message"].stringValue
                print("😋\(response)")
                print("😁\(status)")
                self.stopAnimating()
                if(status == 0){
                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
                }else{
                    self.isOpen = !self.isOpen
                    self.switchButton.setOn(!self.switchButton.isOn, animated: true)
                    ShowTrueMassge(massge: msg , title: "success".localized())

                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
            self.tableView.reloadData()
            self.stopAnimating()
        }
        
    }
}


//MARK:- ActiveDelegate
extension MyProductsViewController: ActiveDelegate{
    func activeAction(withIndex index: Int) {
        selectedIndex = index
        print(selectedIndex, "rrrrrrrrrrr")
        activeProduct(product_id: ProductDataSource[index].product_id ?? 0 )
    }
    
    
}
