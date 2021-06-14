//
//  MyOrdersViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SideMenu

class MyOrdersViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet var storeStatusLabel: UILabel!
    @IBOutlet var switchButton: UISwitch!



    
    var shopId = 0
    var isOpen = false

    var cats: [CatOrder] = []
    var params:Dictionary = [String:Any]()
    var dataArray = NSMutableArray()
    var NewOrderData = [NewOrdersModel]()
    var OrderProudct = [OrderProductsModel]()
    var productId = ""
    let NETWORK = NetworkingHelper()

    var gameTimer: Timer?
    var shouldCallApi = true

    /// IBACtions
//
//    @IBOutlet var imageView1: CircleImageView!
//    @IBOutlet var imageView2: CircleImageView!
//    @IBOutlet var imageView3: CircleImageView!
//    @IBOutlet var imageView4: CircleImageView!
//    @IBOutlet var imageView5: CircleImageView!
//    @IBOutlet var imageView6: CircleImageView!

    @IBOutlet var neadAgreeOrderAction: UIButton!
    
    @IBAction func CLOSEOROPENSTOREACTION(_ sender: Any) {
        openStore()
    }
    @IBAction func FirstneadAgreeOrderAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
        Home.orderType = 1
        self.navigationController?.pushViewController(Home, animated: false)
    }
    
    @IBAction func preparedOrderAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
        Home.orderType = 2
        self.navigationController?.pushViewController(Home, animated: false)

    }
    
    @IBAction func underDeleverdOrderAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
        Home.orderType = 3
        self.navigationController?.pushViewController(Home, animated: false)

    }
    
    @IBAction func deleverdOrderAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
        Home.orderType = 4
        self.navigationController?.pushViewController(Home, animated: false)

    }
    
    @IBAction func storeBalanceAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(MyPocketViewController.self)
        self.navigationController?.pushViewController(Home, animated: false)

    }
    
    @IBAction func misOrderAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
        Home.orderType = 5
        self.navigationController?.pushViewController(Home, animated: false)

    }
    override func viewWillAppear(_ animated: Bool) {
        shouldCallApi = true
        self.tabBarController?.tabBar.isHidden = false
        requestBillsApi()
        getAllProduct(user_id: getUserID())
    }
    
    @objc func refreshCounter(){
        requestBillsApi()
        getAllProduct(user_id: getUserID())

    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        shouldCallApi = false
    }
    
        @objc func runTimedCode(){
            print("ddddddddddd", shouldCallApi)
            if shouldCallApi{
                requestBillsApi()
            }
    //        realTime +=
        }
    @objc func appMovedToBackground() {
        print("App moved to ForeGround!")
        requestBillsApi()
        getAllProduct(user_id: getUserID())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // gameTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        initCommonTableViews()
        initView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshCounter), name: NSNotification.Name("RefreshCounter"), object: nil)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)

        NETWORK.deleget = self
        getAllProduct(user_id: getUserID())

        self.menuBtn.image = #imageLiteral(resourceName: "menu")
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "My Orders".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
//        self.tableView.showsVerticalScrollIndicator = false
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .done, target: self, action: #selector(openChat))
        getShopData()
        
    }
    
    func initCommonTableViews(){
        self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.estimatedRowHeight = 100
    }
    @objc func openChat(){
        print("hiii")
        let Reg = Storyboard.Main.instantiate(ClientMessagesViewController.self)
        self.navigationController?.pushViewController(Reg, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.initCell(withCat: cats[indexPath.row])
        if indexPath.row == 6{
            cell.countLabel.text = "\(cats[indexPath.row].counter) "  + "SR".localized()
        }

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
            Home.orderType = 1
            self.navigationController?.pushViewController(Home, animated: false)
        case 1:
            let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
            Home.orderType = 2
            self.navigationController?.pushViewController(Home, animated: false)
        case 2:
            let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
            Home.orderType = 3
            self.navigationController?.pushViewController(Home, animated: false)
        case 3:
            let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
            Home.orderType = 4
            self.navigationController?.pushViewController(Home, animated: false)
        case 4:
            let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
            Home.orderType = 5
            self.navigationController?.pushViewController(Home, animated: false)
        case 5:
            let Home = Storyboard.Main.instantiate(AcceptedOrdersViewController.self)
            Home.orderType = 6
            self.navigationController?.pushViewController(Home, animated: false)
        case 6:
            let Home = Storyboard.Main.instantiate(MyPocketViewController.self)
            self.navigationController?.pushViewController(Home, animated: false)
        default:
            break
        }
       
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
    
    func getCurrentPreviosOrder(user_id:String){
        let url = ProviderCurrentOrder_Url
        let params: Parameters = [
            "user_id": user_id,
            "lang":getServerLang()
        ]
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].int
                if(status == 1){
                    print("🌹\(response)")
                    guard let dataArray = json["data"].array else {
                        // completion(nil, nil)
                        return
                    }
       
                    
                    self.stopAnimating()
                    
                    
                    for data in dataArray{
                        
                        
                        let order = NewOrdersModel()
                        var additions = [proudctAddtionsOrderModel]()
                        guard let data = data.dictionary else {return}
                        self.OrderProudct = []
                        if let prodctorder = data["order_products"]?.array {
                            
                         
                    
                                
                            let orderprod = OrderProductsModel()
                            for i in 0..<prodctorder.count{
                                
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
                        self.productId = String(order.order_id!)
                        // completion(nil,NewOrderData)
                        
                        
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
                self.tableView.reloadData()
                
                
            case .failure(let error):
                self.stopAnimating()
                // completion(error, nil)
                print(error)
            }
            
        }
        
    }
}


struct CatOrder{
    var id: Int = 0
    var counter = 0
    var name: String = ""
    var image: String = ""
    var details: String = ""
    
    init(id:Int, name:String, image:String, detailse:String, count: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.details = detailse
        self.counter = count
    }
}


extension MyOrdersViewController{
    
    func initView(){
//        collectionView?.collectionViewLayout = CircleLayout()
//        initCommonCollectionView()
        cats.append(CatOrder(id: 1, name: "طلبات تحتاج موافقة", image: "1", detailse: "عدد الطلبات المستلمة: ", count: 0))
        cats.append(CatOrder(id: 2, name: "طلبات قيد التحضير", image: "2", detailse: "عدد الطلبات في مطبخك الان: ", count: 0))
        cats.append(CatOrder(id: 3, name: "طلبات جاهزه في مطبخك", image: "3", detailse: "عدد الطلبات الجاهزه الان: ", count: 0))
        cats.append(CatOrder(id: 4, name: "طلبات في الطريق", image: "4", detailse: "عدد الطلبات الغير مغلقه: ", count: 0))
        cats.append(CatOrder(id: 5, name: "طلبات منتهية", image: "groceries-store", detailse: "عدد الطلبات المنتهية: ", count: 0))
        cats.append(CatOrder(id: 6, name: "طلبات مفقودة", image: "5", detailse: "عدد الطلبات التي لم تتمكن اتمامها: ", count: 0))
        cats.append(CatOrder(id: 7, name: "رصيد المحفظه", image: "6", detailse: "رصيد المحفظه الان: ", count: 0))
        mainQueue {
            self.tableView.reloadData()
        }

    }
}

//MARK:- Networking
extension MyOrdersViewController: NetworkingHelperDeleget {
    func onHelper(getData data: DataResponse<String>, fromApiName name: String, withIdentifier id: String) {
       handelBillsResponse(response: data)
    }
    
    func onHelper(getError error: String, fromApiName name: String, withIdentifier id: String) {
        ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
    }
    
    // MARK:- request apis from server
    func requestBillsApi() {
//        self.startAnimating()
        NETWORK.connectWithHeaderTo(api: "https://top12app.com/api/order/getOrdersCount?lang=ar&user_id=\(getUserID())", withLoader: true, forController: self, methodType: .post)
    }
    // MARK:- handle response server
        func handelBillsResponse(response: DataResponse<String>){
//            self.stopAnimating()

        switch response.response?.statusCode {
        case 200:
              do{
                let resp = try JSONDecoder().decode(CountTypes.self, from: response.data ?? Data())
 
                if resp.status == 200{
                    let wait = resp.waitingApprovalOrdersCount ?? 0
                    let miss = resp.missingOrdersCount ?? 0
                    let prepare = resp.underPrepareOrdersCount ?? 0
                    let under = resp.underDeliveryOrdersCount ?? 0
                    let delevert = resp.underDeliveredOrdersCount ?? 0
                    let inKitchen = resp.inKitchenOrdersCount ?? 0
                    
                    cats[0].counter = wait
                    cats[1].counter = prepare
                    cats[2].counter = inKitchen
                    cats[3].counter = under
                    cats[4].counter = delevert
                    cats[5].counter = miss
                
                    
                    mainQueue {
                        self.tableView.reloadData()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
    //                    ShowTrueMassge(massge: "تم الدفع", title: "")

                    }
                }else{
//                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
//                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())

                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
    //                    ShowTrueMassge(massge: "تم الدفع", title: "")

                    }
                }

            }catch let error{
                print(error,"mina")
//                ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
            }
        default:
            print("mina")

//            ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
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

            }else{
                self.stopAnimating()

            }
        }
    }
    
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

    func getShopData(){
        let url = SHOW_SHOP_DATA
        let params: Parameters = [
            
            "user_id": getUserID(),
            "shop_id": getShopId(),
            "lang":getServerLang()
        ]
        
        API.POST(url: url, parameters: params, headers: [:]) { (success, value) in
            if success{
                self.stopAnimating()
//                let data = value["data"] as! [String:Any]
//                let shop_balance = data["shop_balance"] as! String
//                self.cats[6].counter = Int(shop_balance) ?? 0
                mainQueue {
                    self.tableView.reloadData()
                }

                
            }
        }
        
    }
}
