//
//  ProudctDetilsViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/17/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit
import SideMenu
import Kingfisher
import ImageSlideshow
import ActionSheetPicker_3_0


class ProudctDetilsViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var proudctName: UILabel!
    @IBOutlet weak var moreBtn: UIBarButtonItem!
    @IBOutlet weak var noAdditions: UILabel!
    @IBOutlet weak var pricebefore: UILabel!
    @IBOutlet weak var offerbadge: UIImageView!
    @IBOutlet weak var priveAfter: UILabel!
    @IBOutlet weak var descrip: UITextView!
    @IBOutlet weak var addtionalTitle: UILabel!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var HightProductDetils: NSLayoutConstraint!
    @IBOutlet weak var addtionsNotesHight: NSLayoutConstraint!
    @IBOutlet weak var ScrollViewHeight: NSLayoutConstraint!
     @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var additionNotes: UITextView!
    
    var proudctID = ""
    var proudctTitle = ""
    var params:Dictionary = [String:Any]()
    var dataArray = NSMutableArray()
    var ProductAdditions = [proudctAddtionsOrderModel]()
    let paragraphStyle = NSMutableParagraphStyle()
    var selectableItem = ""
    var imageLink = ""
    var productPrice = ""
    var nameAr = ""
    var nameEn = ""
    var disc = ""
    var CatgId = ""
    var kingfisherArray = [KingfisherSource]()
    var ImageArrrayLinks = [String]()
    @IBAction func moreAction(_ sender: Any) {
       
    }
    
    var additions = [proudctAddtionsOrderModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuTableView()
        self.startAnimating()
        creatNavigationItems()
        self.descrip.isEditable = false
        self.offerbadge.isHidden = true
        self.priveAfter.isHidden = true
        ImageSliderSetting()
        self.offerbadge.image = #imageLiteral(resourceName: "discout")
        self.startAnimating()
        self.tableView.showsVerticalScrollIndicator = false
        //self.descrip.isScrollEnabled = false
        //self.additionNotes.isScrollEnabled = false
        self.tableView.isScrollEnabled = false
        print("💐\(self.proudctID)")
        self.getShopDetils(user_id: getUserID(), product_id: self.proudctID)
        self.addtionalTitle.text = "Additions".localized()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.noAdditions.isHidden = true
        let notfibutton = UIButton(frame: CGRect(x: 0, y: 0, width: 8, height: 16))
        notfibutton.setBackgroundImage(UIImage(named: "more"), for: .normal)
        notfibutton.backgroundColor = UIColor.clear
        notfibutton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        notfibutton.imageView?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        notfibutton.addTarget(self, action: #selector(moreMenu), for: .touchUpInside)
        let notfibar = UIBarButtonItem(customView: notfibutton)
        self.navigationItem.rightBarButtonItem = notfibar
      //  self.navigationItem.leftItemsSupplementBackButton = true
        
    }
    @objc func  moreMenu(sender:UIButton){
    
        paragraphStyle.alignment = .center
        
        let pick2 = ActionSheetStringPicker(title: "", rows: ["Edit".localized(),"Add offer".localized(),"Delete".localized()], initialSelection: 1, doneBlock: {
            picker, indexes, values in
            print(indexes)
            print(values!)
            
            self.selectableItem = (values as? String)!
            if(self.selectableItem == "Add offer".localized()){
                print("hiiiiiii")
              //  self.addOffer()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddOfferViewController") as! AddOfferViewController
                vc.offerID = self.proudctID
                vc.priceBefore = self.productPrice
                vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                
                self.addChildViewController(vc)
                self.view.addSubview(vc.view)

                
            }
            if(self.selectableItem == "Delete".localized()){
                self.startAnimating()
                self.DeleteOffer(product_id: Int(self.proudctID)!)
            }
            if(self.selectableItem == "Edit".localized()){
                defaults.set("edit", forKey: UpdateOrAdd)
                let forgetPass = Storyboard.Main.instantiate(EditProductViewController.self)
                forgetPass.nameArbic = self.nameAr
                forgetPass.nameEnglish = self.nameEn
                forgetPass.price = self.productPrice
                forgetPass.descrip = self.disc
                forgetPass.productID = self.proudctID
                forgetPass.index = self.CatgId
                self.navigationController?.pushViewController(forgetPass, animated: true)
            }
            
            
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
        let bar1 = UIBarButtonItem.init(title: "Done".localized(), style: .plain, target: self, action: #selector(actionPickerCancel))
        let bar2 = UIBarButtonItem.init(title: "Cancel".localized(), style: .plain, target: self, action: #selector(actionPickerCancel))
        
        bar1.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 20) as Any, NSAttributedStringKey.foregroundColor:#colorLiteral(red: 0, green: 0.6980392157, blue: 0.7607843137, alpha: 1)], for: .normal)
        bar2.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 20) as Any, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0.6980392157, blue: 0.7607843137, alpha: 1)], for: .normal)
        
        
        
        pick2?.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular" , size: 20) as Any, NSAttributedStringKey.foregroundColor: UIColorFromRGB(rgbValue: 0x493D30)]
        
        pick2?.setDoneButton(bar1)
        pick2?.setCancelButton(bar2)
        
        pick2?.pickerTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 17) as Any, NSAttributedStringKey.paragraphStyle: paragraphStyle]
        pick2?.show()
    }
    @objc func actionPickerCancel(){
        
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
                    self.navigationController?.popViewController(animated: true)
                }else{
                    ShowErrorMassge(massge: msg!, title: "Error".localized())
                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.ProductAdditions.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdctDetilsTableViewCell", for: indexPath) as! ProdctDetilsTableViewCell
       // cell.price.text = String(describing:self.ProductAdditions[indexPath.section].addition_price!) + " " + "SR".localized()
        cell.price.text =  String(describing:self.ProductAdditions[indexPath.section].addition_price!)
        cell.price.textAlignment = .center
        cell.price.isUserInteractionEnabled = false
        cell.addtions.text = self.ProductAdditions[indexPath.section].addition_name
        cell.addtions.placeholder = "Special Additions"
        cell.addtions.textAlignment = .center
        cell.addtions.isUserInteractionEnabled = false
        
        cell.SRlbl.text! = "SR".localized()
        return cell
    }
    func ImageSliderSetting(){
        
        imageSlider.slideshowInterval = 5.0
        imageSlider.contentScaleMode = .scaleToFill
        imageSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        let pageContrller = UIPageControl()
        pageContrller.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.7607843137, alpha: 1)
        pageContrller.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageSlider.pageIndicator = pageContrller
        //        imageSliderShow.activityIndicator = DefaultActivityIndicator()
        //        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        //        pageControl.pageIndicatorTintColor = UIColor.black
        //        pageControl.tintColor = mtnRedColor
        //        imageSliderShow.pageIndicator = pageControl
        
        
        imageSlider.activityIndicator = DefaultActivityIndicator()
        imageSlider.currentPageChanged = { page in
            print("current page:", page)
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlider.addGestureRecognizer(recognizer)
        
    }
    @objc func didTap() {
        let fullScreenController = imageSlider.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    func configureMenuTableView(){
        tableView.register(UINib(nibName: "ProdctDetilsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProdctDetilsTableViewCell")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    
    
    
    func creatNavigationItems() {
        
        let customtitle = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        customtitle.textColor = UIColor.white
        customtitle.text = self.proudctTitle
        customtitle.font = UIFont(name: "JF-Flat-medium.ttf", size: 15)
        customtitle.textAlignment = .center
        navigationItem.titleView = customtitle
        
     
        
    }
    @objc func openmenue () {
        SideMenuManager.default.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "MenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        
    }
 
    func addOffer(){
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddOfferViewController") as! AddOfferViewController
        //        vc.offerID = proudctID
        //        vc.priceBefore = self.productPrice
        //        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        //
        //        self.addChildViewController(vc)
        //        self.view.addSubview(vc.view)
    }
    
    
    func getShopDetils(user_id:String,product_id:String){
        
        let url = ShopDetils_Url
        let params: Parameters = [
            
            "user_id": user_id,
            "product_id":product_id,
            "lang":getServerLang()
        ]
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print("🌹\(response)")
                let json = JSON(value)
                let status = json["status"].int
                let data = json["data"].dictionary
                let product_name = json["data"]["product_name"].string
    
                let product_price = json["data"]["product_price"].string
                let product_category_id = json["data"]["product_category_id"].int
                let product_offer_price = json["data"]["product_offer_price"].int
                self.CatgId = String(describing: product_category_id!)
                let priceBefore =  product_price! + " " + "SR".localized()
                
                if(product_offer_price != 0){
                    self.productPrice = product_price!
                    self.pricebefore.attributedText = priceBefore.strikeThrough()
                    self.priveAfter.text = String(product_offer_price!) + " " + "SR".localized()
                    self.offerbadge.isHidden = false
                    self.priveAfter.isHidden = false
                }else{
                    self.productPrice = product_price!
                    self.pricebefore.text = priceBefore
                  
                    self.offerbadge.isHidden = true
                    self.priveAfter.isHidden = true
                }
                
            
              
                
                let product_disc = json["data"]["product_disc"].string
                self.disc = product_disc!
                if(status == 1){
                  
                    let images = data!["product_images"]?.array
                    for dic in images!{
                        let dica = dic.dictionary
                        let imageLike = dica!["image_path"]?.string
                        self.ImageArrrayLinks.append(imageLike!)
                        let img = KingfisherSource(urlString: imageLike!)
                        self.kingfisherArray.append(img!)
                     }
                    self.imageSlider.setImageInputs(self.kingfisherArray)
                    print("🤮\(self.kingfisherArray)")
                    self.descrip.text = product_disc
                    self.HightProductDetils.constant = self.descrip.contentSize.height + 10
                    
                  
                    self.proudctName.text = product_name
                    self.proudctTitle = product_name!
                    if (json["data"]["product_extra_info"].string != ""){
                           self.additionNotes.text = json["data"]["product_extra_info"].string
                           self.addtionsNotesHight.constant = self.additionNotes.contentSize.height + 10
                    }else{
                         self.additionNotes.text = "No Addition Notes".localized()
                         self.addtionsNotesHight.constant = self.additionNotes.contentSize.height + 10
                    }
                 
                    if let proudctAddtions = data!["product_additions"]?.array {
                        for i in 0..<proudctAddtions.count{
                            var prodadd = proudctAddtionsOrderModel()
                            prodadd.addition_id = proudctAddtions[i]["id"].int
                            prodadd.addition_name = proudctAddtions[i]["name_ar"].stringValue
                            prodadd.addition_price = Int(proudctAddtions[i]["price"].string!)!
                            print("😭\(prodadd.addition_price)")
                            self.ProductAdditions.append(prodadd)
                            self.tableViewHeight.constant = CGFloat(60 * self.ProductAdditions.count)
                            
                        }
                        self.tableView.reloadData()
                        if (self.ProductAdditions.count == 0){
                            self.noAdditions.isHidden = false
                            self.noAdditions.text = "No special additions".localized()
                            self.ScrollViewHeight.constant = CGFloat(680 + self.tableView.contentSize.height) + self.additionNotes.contentSize.height + self.descrip.contentSize.height
                            
                        }else{
                              self.noAdditions.isHidden = true
                              self.ScrollViewHeight.constant = CGFloat(600 + self.tableView.contentSize.height) + self.additionNotes.contentSize.height + self.descrip.contentSize.height
                            
                            
                            
                        }
                        self.stopAnimating()
                        
                        
                    }
                   
                }
                
            case .failure(let error):
                self.stopAnimating()
                print(error)
            }
            
        }
        
    }
  
    
}
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
