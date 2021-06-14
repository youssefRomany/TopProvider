//
//  AcceptedOrdersViewController.swift
//  Top12
//
//  Created by YoussefRomany on 5/10/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SideMenu

class AcceptedOrdersViewController: UIViewController {

    @IBOutlet var noOrderImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var menuBtn: UIBarButtonItem!
//    @IBOutlet weak var noOrder: UIImageView!

    var cats: [CatOrder] = []
    var params:Dictionary = [String:Any]()
    var dataArray = NSMutableArray()
    var NewOrderData = [Final]()
    var OrderProudct = [OrderProductsModel]()
    var productId = ""
    var orderType = 1

    ///Constant
    let NETWORK = NetworkingHelper()
    let SEARCH_ADS_LIST = "SEARCH_ADS_LIST"
    let refresher:UIRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        noOrderImageView.image = UIImage(named: "orderempty")
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        self.tableView.showsVerticalScrollIndicator = false
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .done, target: self, action: #selector(openChat))
        initCommonTableView()
        NETWORK.deleget = self
        
//        cats.append(CatOrder(id: 1, name: "طلبات تحتاج موافقة", image: "1", detailse: "عدد الطلبات المستلمة: ", count: 0))
//        cats.append(CatOrder(id: 2, name: "طلبات قيد التحضير", image: "2", detailse: "عدد الطلبات في مطبخك الان: ", count: 0))
//        cats.append(CatOrder(id: 3, name: "طلبات جاهزه في مطبخك", image: "3", detailse: "عدد الطلبات الجاهزه الان: ", count: 0))
//        cats.append(CatOrder(id: 4, name: "طلبات في الطريق", image: "4", detailse: "عدد الطلبات الغير مغلقه: ", count: 0))
//        cats.append(CatOrder(id: 5, name: "طلبات منتهية", image: "4", detailse: "عدد الطلبات المنتهية: ", count: 0))
//        cats.append(CatOrder(id: 6, name: "طلبات مفقودة", image: "5", detailse: "عدد الطلبات التي لم تتمكن اتمامها: ", count: 0))

        switch orderType {
        case 1:
            self.navigationItem.title = "طلبات تحتاج موافقة".localized()
        case 2:
            self.navigationItem.title = "طلبات قيد التحضير".localized()
        case 3:
            self.navigationItem.title = " طلبات جاهزه في مطبخك".localized()
        case 4:
            self.navigationItem.title = "طلبات في الطريق".localized()
        case 5:
            self.navigationItem.title = "طلبات منتهية".localized()
        case 6:
            self.navigationItem.title = "طلبات مفقودة".localized()
        case 7:
            self.navigationItem.title = "My Orders".localized()
        default:
            self.navigationItem.title = "My Orders".localized()

        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshCounter), name: NSNotification.Name("RefreshCounter"), object: nil)

        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)

    }
    
    @objc func refreshCounter(){
        requestOrdersApi()

    }
    @objc func appMovedToBackground() {
        print("App moved to ForeGround!")
        requestOrdersApi()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        requestOrdersApi()
    }
    
    @objc func openChat(){
        print("hiii")
        let Reg = Storyboard.Main.instantiate(ClientMessagesViewController.self)
        self.navigationController?.pushViewController(Reg, animated: true)
    }
    

        /// init table view
        func initCommonTableView(){
            tableView.register(UINib(nibName: "waiteingOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "waiteingOrdersTableViewCell")
            
            tableView.register(UINib(nibName: "UnderPreparedTableViewCell", bundle: nil), forCellReuseIdentifier: "UnderPreparedTableViewCell")
            
            tableView.register(UINib(nibName: "UnderDeleverdTableViewCell", bundle: nil), forCellReuseIdentifier: "UnderDeleverdTableViewCell")

            tableView.register(UINib(nibName: "MissedOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "MissedOrderTableViewCell")
            
            
            tableView.register(UINib(nibName: "waiteingOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "waiteingOrdersTableViewCell")
            
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

        }
    /// called when the user pull  table view to refresh the favourites
    @objc func updateTableView() {
        
        requestOrdersApi()

    }

    
//    @IBAction func openMenu(_ sender: Any) {
//
//        if(getServerLang() == "en"){
//            let sideMenuVc = Storyboard.Main.instantiate(ProviderSideMenuViewController.self)
//            let menuNavgtion = UISideMenuNavigationController(rootViewController: sideMenuVc)
//            SideMenuManager.default.menuAddPanGestureToPresent(toView: (self.navigationController?.navigationBar)!)
//            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView:(self.navigationController?.navigationBar)! )
//            SideMenuManager.default.menuFadeStatusBar = false
//            SideMenuManager.default.menuPresentMode = .viewSlideInOut
//            SideMenuManager.default.menuShadowOpacity = 0.5
//            SideMenuManager.default.menuAnimationBackgroundColor =  UIColor(patternImage: UIImage(named: "sideMenubg")!)
//            SideMenuManager.default.menuLeftNavigationController = menuNavgtion
//            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
//        }else{
//            let sideMenuVc = Storyboard.Main.instantiate(ProviderSideMenuViewController.self)
//            let menuNavgtion = UISideMenuNavigationController(rootViewController: sideMenuVc)
//            SideMenuManager.default.menuAddPanGestureToPresent(toView: (self.navigationController?.navigationBar)!)
//            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView:(self.navigationController?.navigationBar)! )
//            SideMenuManager.default.menuFadeStatusBar = false
//            SideMenuManager.default.menuPresentMode = .viewSlideInOut
//            SideMenuManager.default.menuShadowOpacity = 0.5
//            SideMenuManager.default.menuAnimationBackgroundColor =  UIColor(patternImage: UIImage(named: "sideMenubg")!)
//            SideMenuManager.default.menuRightNavigationController = menuNavgtion
//            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
//        }
//    }

}



extension AcceptedOrdersViewController: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.NewOrderData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch orderType {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "waiteingOrdersTableViewCell", for: indexPath) as! waiteingOrdersTableViewCell
            cell.initCell(withOrder: self.NewOrderData[indexPath.row])
            return cell
        case 2:
            
            if self.NewOrderData[indexPath.row].order_status == "order ready"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UnderDeleverdTableViewCell", for: indexPath) as! UnderDeleverdTableViewCell
                cell.initCell(withOrder: self.NewOrderData[indexPath.row])
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UnderPreparedTableViewCell", for: indexPath) as! UnderPreparedTableViewCell
                cell.initCell(withOrder: self.NewOrderData[indexPath.row])
                return cell

            }
        case 3:
            
            if self.NewOrderData[indexPath.row].order_status == "order ready"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UnderDeleverdTableViewCell", for: indexPath) as! UnderDeleverdTableViewCell
                cell.initCell(withOrder: self.NewOrderData[indexPath.row])
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "UnderPreparedTableViewCell", for: indexPath) as! UnderPreparedTableViewCell
                cell.initCell(withOrder: self.NewOrderData[indexPath.row])
                return cell

            }

        case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "UnderDeleverdTableViewCell", for: indexPath) as! UnderDeleverdTableViewCell
                cell.initCell(withOrder: self.NewOrderData[indexPath.row])
                return cell
        case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MissedOrderTableViewCell", for: indexPath) as! MissedOrderTableViewCell
                cell.initCell(withOrder: self.NewOrderData[indexPath.row])
                cell.orderStatuseLabel.isHidden = true
                
                return cell
        case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "MissedOrderTableViewCell", for: indexPath) as! MissedOrderTableViewCell
                cell.initCell(withOrder: self.NewOrderData[indexPath.row])
                return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MissedOrderTableViewCell", for: indexPath) as! MissedOrderTableViewCell
            cell.orderStatuseLabel.isHidden = true
            return cell
            
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch orderType {
        case 1:
            return 150
        case 2:
            return 120
        case 3:
            return 170
        case 4:
            return 170
        case 5:
            return 100
        case 6:
            return 120
        default:
            return 120
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.NewOrderData[indexPath.row].order_status, "dddddddddddddd")
        if orderType != 1{
        switch (self.NewOrderData[indexPath.row].order_status ?? "") {
        case "client refused":
            let Home = Storyboard.Main.instantiate(MyOrdersDetilsViewController.self)
            Home.ProductId = String(describing: self.NewOrderData[indexPath.section].order_id!)
            Home.orderStatusFlag = "refused"
            self.navigationController?.pushViewController(Home, animated: false)
        case "provider refused":
            let Home = Storyboard.Main.instantiate(MyOrdersDetilsViewController.self)
            Home.ProductId = String(describing: self.NewOrderData[indexPath.row].order_id!)
            Home.orderStatusFlag = "refused"
            self.navigationController?.pushViewController(Home, animated: false)
        case "order finish" :
            let Home = Storyboard.Main.instantiate(MyOrdersDetilsViewController.self)
            Home.ProductId = String(describing: self.NewOrderData[indexPath.row].order_id!)
            Home.orderStatusFlag = "refused"
            self.navigationController?.pushViewController(Home, animated: false)
        case "order failed" :
            let Home = Storyboard.Main.instantiate(MyOrdersDetilsViewController.self)
            Home.ProductId = String(describing: self.NewOrderData[indexPath.row].order_id!)
            Home.orderStatusFlag = "refused"
            self.navigationController?.pushViewController(Home, animated: false)
        case "user waiting":
            let Home = Storyboard.Main.instantiate(MyOrdersDetilsViewController.self)
            Home.ProductId = String(describing: self.NewOrderData[indexPath.row].order_id!)
            Home.orderStatusFlag = "refused"
            self.navigationController?.pushViewController(Home, animated: false)
        default:
            let Home = Storyboard.Main.instantiate(MyOrdersDetilsViewController.self)
            Home.ProductId = String(describing: self.NewOrderData[indexPath.row].order_id!)
            Home.orderStatusFlag = "ckint"
            Home.deliveryTime = Double(self.NewOrderData[indexPath.row].order_delivery_time ?? 0) 
            self.navigationController?.pushViewController(Home, animated: false)
        }
        }else{
            let Home = Storyboard.Main.instantiate(NewOrderDetilsViewController.self)
            Home.ProductId = String(describing: self.NewOrderData[indexPath.row].order_id!)
            self.navigationController?.pushViewController(Home, animated: false)

        }
       
    }
    
    /*
     https://top12app.com/api/order/getWaitingApprovalOrders?user_id=585
     https://top12app.com/api/order/getMissingOrders?user_id=585
     https://top12app.com/api/order/getUnderPrepareOrders?user_id=585
     https://top12app.com/api/order/getUnderDeliveryOrders?user_id=585
     https://top12app.com/api/order/getUnderDeliveredOrders?user_id=585
     */
    

}



//MARK:- Networking
extension AcceptedOrdersViewController: NetworkingHelperDeleget {
    func onHelper(getData data: DataResponse<String>, fromApiName name: String, withIdentifier id: String) {
       handelBillsResponse(response: data)
        mainQueue {
                self.refresher.endRefreshing()
        }
    }
    
    func onHelper(getError error: String, fromApiName name: String, withIdentifier id: String) {
        mainQueue {
                 self.refresher.endRefreshing()
         }
        ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
    }
    
    // MARK:- request apis from server
    func requestOrdersApi() {
        self.startAnimating()
        
        var url = "https://top12app.com/api/order/getWaitingApprovalOrders"

        switch orderType {
        case 1:
             url = "https://top12app.com/api/order/getWaitingApprovalOrders"
        case 2:
             url = "https://top12app.com/api/order/getUnderPrepareOrders"
        case 3:
             url = "https://top12app.com/api/order/getinKitchenOrders"
        case 4:
             url = "https://top12app.com/api/order/getUnderDeliveryOrders"
        case 5:
             url = "https://top12app.com/api/order/getUnderDeliveredOrders"
        case 6:
             url = "https://top12app.com/api/order/getMissingOrders"
        default:
             url = "https://top12app.com/api/order/getWaitingApprovalOrders"
        }
        print("eeeeeee", url )

        
        let params: Parameters = [
            "user_id": getUserID(),
        ]
        print(params, GET_BILLS )
        NETWORK.connectWithHeaderTo(api: url, withParameters: params, withLoader: true, forController: self, methodType: .post)
    }
    
    // MARK:- handle response server
        func handelBillsResponse(response: DataResponse<String>){
            self.stopAnimating()

        switch response.response?.statusCode {
        case 200:
              do{
                let resp = try JSONDecoder().decode(OrderJoeModel.self, from: response.data ?? Data())
                if resp.status == 200{
                    self.NewOrderData.removeAll()
                    self.NewOrderData = resp.final ?? []
                    if self.NewOrderData.count == 0 {
                        noOrderImageView.isHidden = false
                    }else{
                        noOrderImageView.isHidden = true
                    }
                }else{
//                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
                }
                mainQueue {
                    self.tableView.reloadData()
                }
                
            }catch let error{
                print(error,"mina")
//                ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
            }
        default:
            print("fffffmina")
//            ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
        }
    }

}
