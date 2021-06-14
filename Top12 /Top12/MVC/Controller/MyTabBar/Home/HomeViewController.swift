//
//  HomeViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SwiftyJSON
class HomeViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate  {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var noOrder: UIImageView!
    @IBOutlet var storeStatusLabel: UILabel!
    @IBOutlet var switchButton: UISwitch!
    
    var Orders = [PreviosOrderModel]()
    var params:Dictionary = [String:Any]()
    var dataArray = NSMutableArray()
    var NewOrderData = [NewOrdersModel]()
    var OrderProudct = [OrderProductsModel]()
    var productId = ""
    var shopId = 0
    var isOpen = false
    
    let refresher:UIRefreshControl = UIRefreshControl()

    /// called when the user pull  table view to refresh the favourites
    @objc func updateTableView() {
        
//        getAllProduct(user_id: getUserID())
        self.getProviderNewOrder(user_id: getUserID())
        print("mmmmmmmmmmmmmmmmmmmmmmm")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        if #available(iOS 10.0, *)
        {
            tableView.refreshControl = refresher
        }
        else{
            tableView.addSubview(refresher)
        }
        
        // Configure Refresh Control
        refresher.addTarget(self, action: #selector(self.updateTableView), for: .valueChanged)

        self.noOrder.image = #imageLiteral(resourceName: "orderempty")
        self.noOrder.isHidden = true
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "Home".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        print("🔴\(AppDelegate.FCMTOKEN)")
      

        if(getServerLang() == "en"){
           UITableView.appearance().semanticContentAttribute = .forceLeftToRight
        }else{
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
        }
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .done, target: self, action: #selector(openChat))

        
    }
    @IBAction func CLOSEOROPENSTOREACTION(_ sender: Any) {
        openStore()
    }
    
    @objc func openChat(){
        print("hiii")
        let Reg = Storyboard.Main.instantiate(ClientMessagesViewController.self)
        self.navigationController?.pushViewController(Reg, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let name2 = Notification.Name("goToMsgs")
        self.tabBarController?.tabBar.isHidden = false
        UIApplication.shared.applicationIconBadgeNumber = 0

        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveMsg(_:)), name: name2, object: nil)
        if UserDefaults.standard.bool(forKey: "isMsg") {
            
            let vc =  Storyboard.Main.instantiate(ClientMessagesViewController.self)
            self.navigationController?.pushViewController(vc, animated: false)
            
            getAllProduct(user_id: getUserID())

        }
        
        self.NewOrderData  = []
        self.tableView.reloadData()
        self.startAnimating()
        self.getProviderNewOrder(user_id: getUserID())
        self.menuBtn.image = #imageLiteral(resourceName: "menu")
    }
    @objc func onDidReceiveMsg(_ notification:Notification) {
        
        let vc =  Storyboard.Main.instantiate(ClientMessagesViewController.self)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.NewOrderData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HimeTableViewCell", for: indexPath) as! HimeTableViewCell
        cell.orderTime.text = "Order Time :".localized() + " " + self.NewOrderData[indexPath.section].order_created_at!
        cell.UserName.text = self.NewOrderData[indexPath.section].order_user_name!
        cell.userCity.text = self.NewOrderData[indexPath.section].order_user_city!
        
        cell.orderNumber.text = "Order Number :".localized() + " " + String(describing: self.NewOrderData[indexPath.section].order_id!)
//        cell.userImage.kf.setImage(with: URL.init(string: self.NewOrderData[indexPath.section].order_user_avatar!),placeholder: #imageLiteral(resourceName: "user"),options:nil, progressBlock:nil ,completionHandler:nil)
//        cell.userImage.kf.setImage(with: URL.init(string: self.NewOrderData[indexPath.section].order_user_avatar!),placeholder: #imageLiteral(resourceName: "user"),options:nil, progressBlock:nil ,completionHandler:nil)
        cell.userImage.setImageWith(self.NewOrderData[indexPath.section].order_user_avatar!)
        cell.userImage.layer.borderWidth = 1
        cell.userImage.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 30
        cell.clipsToBounds  = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Home = Storyboard.Main.instantiate(NewOrderDetilsViewController.self)
        Home.ProductId = String (self.NewOrderData[indexPath.section].order_id!)
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
    
    
    func getAllProduct(user_id:String){
        let params:Parameters = [
            "user_id":user_id
        ]
        API.POST(url: ShopData_Url, parameters: params, headers: nil) { (succss, value) in
            if succss{
                print("☘️\(value)")
                self.stopAnimating()
                let status = value["status"] as?  Int ?? 0

                if(status == 1){
                    
                
                let data = value["data"] as! [String:Any]
                    self.shopId = data["shop_id"] as? Int ?? 0
                    self.isOpen = data["shop_open"] as! Bool
                    print("isOpen", self.isOpen)
                    self.switchButton.setOn(self.isOpen, animated: true)
                    self.storeStatusLabel.text = self.isOpen ? "Open".localized() : "Closed".localized()
                    


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
                mainQueue {
                    self.tableView.reloadData()
                         self.refresher.endRefreshing()
                 }

            }else{
                self.stopAnimating()
                mainQueue {
                         self.refresher.endRefreshing()
                 }
            }
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
                    self.storeStatusLabel.text = self.isOpen ? "Open".localized() : "Closed".localized()

                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
            self.tableView.reloadData()
            self.stopAnimating()
        }
        
    }
    
    func getProviderNewOrder(user_id:String){
        let url = ProviderNewOrder_Url
        let params: Parameters = [
            
            "user_id": user_id,
            "lang":getServerLang()
        ]
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].int
                 print("🌹\(response)")
                
                if(status == 1){
                    self.NewOrderData  = []

                    print("🌹\(response)")
                    guard let dataArray = json["data"].array else {
                        // completion(nil, nil)
                        return
                    }
                    if(json["data"].array!.count == 0){
                         self.noOrder.isHidden = false
                    }else{
                         self.noOrder.isHidden = true
                    }
                    
                    self.stopAnimating()
                    for data in dataArray{
                        let order = NewOrdersModel()
                        let orderprod = OrderProductsModel()
                        var additions = [proudctAddtionsOrderModel]()
                        guard let data = data.dictionary else {return}
                        self.OrderProudct = []
                        if let prodctorder = data["order_products"]?.array {
                          
                                
                            for i in 0..<prodctorder.count{
                                additions = []
                             
                                if let product_additions = prodctorder[i]["product_additions"].array{
                                    for pa in product_additions{
                                        let addition_id = pa["addition_id"].int
                                        let addition_name = pa["addition_name"].string
                                        let addition_count = pa["addition_count"].int
                                        let addition_price = pa["addition_price"].int
                                        additions.append(proudctAddtionsOrderModel(addition_id: addition_id, addition_name: addition_name, addition_price: addition_price, addition_count: addition_count))
                                    }
                                    
                                }
                                orderprod.product_count = prodctorder[i]["product_count"].int
                                orderprod.product_price = prodctorder[i]["product_price"].int
                                orderprod.product_id = prodctorder[i]["product_id"].int
                                orderprod.product_name = prodctorder[i]["product_name"].string
                                orderprod.product_additions = additions
                                self.OrderProudct.append(orderprod)
                                print("💛🌸💕\(orderprod.product_additions)")
                            }
                            
                        }
                        
                        order.order_id = data["order_id"]?.int
                        order.order_user_id = data["order_user_id"]?.int
                        order.order_delegate_id = data["order_delegate_id"]?.int
                        order.order_way_type = data["order_way_type"]?.int
                        order.order_status = data["order_status"]?.string
                        order.total_price = data["total_price"]?.int
                        order.delegate_price = data["delegate_price"]?.int
                        order.disc_price = data["disc_price"]?.int
                        order.net_price = data["net_price"]?.int
                        order.order_user_name = data["order_user_name"]?.string
                        order.order_user_avatar = data["order_user_avatar"]?.string
                        order.order_user_city = data["order_user_city"]?.string
                        order.order_delegate_name = data["order_delegate_name"]?.string
                        order.order_created_at = data["order_created_at"]?.string
                        order.order_refused_reason = data["order_refused_reason"]?.string
                        order.order_foreign_delegate = data["order_foreign_delegate"]?.bool
                        order.order_products = self.OrderProudct
                        self.NewOrderData.append(order)
                        // completion(nil,NewOrderData)
                        print("💛\(order.order_id!)")
                        self.productId = String(order.order_id!)
                    }
                    mainQueue {
                       self.tableView.reloadData()

                            self.refresher.endRefreshing()
                    }
                }else{
                    self.stopAnimating()
                    let json = JSON(value)
                    let msg = json["msg"].stringValue
                    ShowErrorMassge(massge: msg, title: "Error".localized())
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // change 2 to desired number of
                        let Reg = Storyboard.Main.instantiate(LoginViewController.self)
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(Reg, animated: true)
                        
                    }
                    
                    
                }
                mainQueue {
                   self.tableView.reloadData()

                        self.refresher.endRefreshing()
                }
                if(self.NewOrderData.count == 0){
               //     self.noOrderLogo.isHidden = false
                }else{
                  //  self.noOrderLogo.isHidden = true
                }
                
            case .failure(let error):
                self.stopAnimating()
                // completion(error, nil)
                print(error)
            }
            
        }
        
    }
    
}

