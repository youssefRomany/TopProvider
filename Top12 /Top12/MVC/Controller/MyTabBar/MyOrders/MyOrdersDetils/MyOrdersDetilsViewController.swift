//
//  MyOrdersDetilsViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class MyOrdersDetilsViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    
    var OrderProudct = [joeOrder_products]()

    
    var net_price = 0.0
    var provider_commision = 0.0
    var fristTime = true
    
    var client_lat = ""
    var client_lng = ""
    
    var provider_lat :String!
    var provider_lng :String!
    
    var currentStatuse = ""
    var cellHieght = CGFloat(150)
    var isEarly = false
    var deliveryTime = 0.0
    var currenttime = NSDate().timeIntervalSince1970

    @IBOutlet var orderTimeView: UIView!
    @IBOutlet var timeLabel: UILabel!

    @IBOutlet var tableViewHight: NSLayoutConstraint!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet var appMoneyLabel: UILabel!
    @IBOutlet var orderPriceLabel: UILabel!
    @IBOutlet var deliveryPrice: UILabel!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var deliverView: UIView!

    
    @IBOutlet weak var orderProssesd: RoundedButton!
    
    var ProductId = ""
    var orderStatusFlag = ""
    var orderStatus = ""
    var currntOrderStatus = ""
    var orderHaveDelgate = ""
//    var OrderProudct = [OrderProductsModel]()
    ///Constant
    let NETWORK = NetworkingHelper()
    let LOGIN = "login"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("dedwedwedwedwed")
        print("nnnnnnn ",(deliveryTime-currenttime)/60)
        configureMenuTableView()
        NETWORK.deleget = self
        self.mapView.cornerRadius = 5
        self.orderImage.layer.cornerRadius = 35
        self.orderImage.layer.borderWidth = 1
        self.orderImage.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.ShowProduct(user_id: getUserID(), order_id: self.ProductId)
        self.requestOrderDataApi(user_id: getUserID(), order_id: self.ProductId)

        mapView.delegate = self
        self.tableView.showsVerticalScrollIndicator = false
//         self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .done, target: self, action: #selector(openChat))
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")

    }
    
    @IBAction func AgreeOrder(_ sender: Any) {
        print("🍉\(self.orderStatus)")
        if self.orderStatus == "order ready" && isEarly{
            if (deliveryTime-currenttime)/60 < 60{
                print("mashrot")
                self.changeState(order_id: self.ProductId , status: self.orderStatus, user_id: getUserID())
            }else{
                popUpView.isHidden = false
            }
        }else{
            
            self.changeState(order_id: self.ProductId , status: self.orderStatus, user_id: getUserID())
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        popUpView.isHidden = true
    }
    
    @IBAction func shareLocationAction(_ sender: Any) {
        share(items: [URL(string:"http://maps.google.com/maps?saddr=\(client_lat),\(client_lng)")!], forController: self)
        print(URL(string:"http://maps.google.com/maps?saddr=\(client_lat),\(client_lng)")!, "rrrrrrrrrrr")
    }
    

        @IBAction func openLocationInGoogleMaps(_ sender: Any) {
            print("🌓\(self.provider_lng!)")
            print(self.client_lat, self.client_lng, "mmmmmmmmmmmmm  11")

            if (UIApplication.shared.canOpenURL(URL(string:"https://")!)) {
    //            UIApplication.shared.open(URL(string:"https://maps.google.com//?saddr=\(self.provider_lat!),\(self.provider_lng!)&daddr=\(self.client_lat),\(self.client_lng)&directionsmode=transit")!, options: [:], completionHandler: nil)
                
                UIApplication.shared.open(URL(string:"http://maps.google.com/maps?saddr=\(client_lat),\(client_lng)")!, options: [:], completionHandler: nil)

            } else {
                print("Can't use comgooglemaps://")
            }
        }
    
    func share(items:[Any], forController controller:UIViewController, excludedActivityTypes types:[UIActivity.ActivityType]? = nil) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = controller.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = types
        
        // present the view controller
        controller.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func openChat(){
        print("hiii")
        let vc =  Storyboard.Main.instantiate(ClientchatViewController.self)
        vc.order_id = self.ProductId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
       
        self.tabBarController?.tabBar.isHidden = true
        if(orderStatusFlag == "refused"){
            self.orderProssesd.isHidden = true
        }
    }
    


    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return 1
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//      return self.OrderProudct.count
//
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NewOrderTableViewCell", for: indexPath) as! NewOrderTableViewCell
//        cell.proudctName.text = self.OrderProudct[indexPath.section].product_name!
//        cell.productPrice.text = String(describing: self.OrderProudct[indexPath.section].product_price!) + " " + "SR".localized()
//        cell.totalPrice.text = "Total Price".localized()
//        cell.total.text = String(describing: self.OrderProudct[indexPath.section].Total_price!) + " " + "SR".localized()
//        cell.netPrice.text = String(describing: self.net_price) + " " + "SR".localized()
//        cell.commision.text = String(describing: self.net_price) + " " + "SR".localized()
//        if(self.OrderProudct[indexPath.section].product_additions.count == 0){
//            cell.noAdditions.text = "No Special Additions in this order".localized()
//            cell.noAdditions.isHidden = false
//        }else{
//            cell.noAdditions.isHidden = true
//        }
//        cell.hightTableView.constant = CGFloat(Int(self.OrderProudct[indexPath.section].product_additions.count * 50))
//        cell.addtionsTableView.reloadData()
//        cell.AddtionsData = self.OrderProudct[indexPath.section].product_additions
//        cell.selectionStyle = .none
//        cell.layer.cornerRadius = 15
//        cell.clipsToBounds  = true
//        return cell
//    }
//    func configureMenuTableView(){
//        tableView.register(UINib(nibName: "NewOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "NewOrderTableViewCell")
//        tableView.reloadData()
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return CGFloat(Int( self.OrderProudct[indexPath.row].product_additions.count * 60) + 150)
//    }
    
       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 1
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0.00001
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            
            return self.OrderProudct.count
            
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            cell.configureCell(withcart: self.OrderProudct[indexPath.section], fromController: self, withIndex: indexPath.row)
            cell.nameLabel.text = self.OrderProudct[indexPath.section].product_name!
            cell.priceLabel.text = String(describing: self.OrderProudct[indexPath.section].product_price!) + " " + "SR".localized()
            print(String(describing: self.OrderProudct[indexPath.section].product_price!) + " " + "SR".localized())
    //        cell.totalPrice.text = "Total Price".localized()
    //        cell.total.text = String(describing: self.OrderProudct[indexPath.section].Total_price!) + " " + "SR".localized()
    //        cell.netPrice.text = String(describing: self.net_price) + " " + "SR".localized()
    //        cell.commision.text = String(describing: self.net_price) + " " + "SR".localized()
    //        cell.AddtionsData = self.OrderProudct[indexPath.section].product_additions
    //        if(self.OrderProudct[indexPath.section].product_additions.count == 0){
    //            cell.noAdditions.text = "No Special Additions in this order".localized()
    //            cell.noAdditions.isHidden = false
    //        }else{
    //            cell.noAdditions.isHidden = true
    //        }
    ////        cell.hightTableView.constant = CGFloat(Int(self.OrderProudct[indexPath.section].product_additions.count * 50))
    //        cell.addtionsTableView.reloadData()
    //        print("🌔\(self.OrderProudct[indexPath.section].product_additions.count)")
    //        cell.selectionStyle = .none
    //        cell.layer.cornerRadius = 15
    //        cell.clipsToBounds  = true
            
            return cell
        }
        func configureMenuTableView(){
            tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
            tableView.reloadData()
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
    //       return CGFloat(Int( self.OrderProudct[indexPath.row].product_additions.count * 60) + 150)
            return cellHieght
          
        }
    func changeState(order_id:String,status:String,user_id:String){
        let params: Parameters = [
            "order_id":order_id,
            "lang":"en",
            "status":status,
            "user_id":user_id
        ]
        
        print(params, "mrmr")
        Alamofire.request(ChangeOrderStatus_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let status = json["status"].int
                let msg = json["msg"].string
                self.stopAnimating()
                print("😁\(response)")
                print("🍉\(params)")
                
                
                self.fristTime = false

                self.CheackOrderStatus()
                print(self.currentStatuse, "nnnnnnnnnnnnnnnnn", self.orderHaveDelgate)
//                if self.currentStatuse == "delegate received" && (self.orderHaveDelgate == "yes"){
//                    self.navigationController?.popViewController(animated: true)
//                }
                

                if(status == 1){
                    ShowTrueMassge(massge: msg!, title: "Succss".localized())
                    if self.currentStatuse == "client confirmed"{
                        self.navigationController?.popToRootViewController(animated: true)
//                        self.ShowProduct(user_id: getUserID(), order_id: self.ProductId)
//                        self.requestOrderDataApi(user_id: getUserID(), order_id: self.ProductId)

                    }else{
//                        self.navigationController?.popViewController(animated: true)
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }else{
                    ShowErrorMassge(massge: msg!, title: "Error".localized())
                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
            }
        }
        
    }
    func CheackOrderStatus(){
        if(self.orderHaveDelgate == "yes"){
                print("cccccccc yes", self.currntOrderStatus)
                    switch self.currntOrderStatus {
                    case "client refused":
                        print("hiii333333333")
                   case "client confirmed":
                    print("🌹\(self.currntOrderStatus)")
                    self.orderStatus =  "order ready"
                    self.orderProssesd.setTitle("order ready".localized(), for: .normal)
                    case "provider accept":
                        self.orderProssesd.isHidden = false
                    case "order ready":
                        self.orderStatus =  "delegate received"
                        self.orderProssesd.setTitle("delegate received".localized(), for: .normal)
                    case "on way":
                        self.orderStatus =  "order received to client"
                        self.orderProssesd.setTitle("order received to client".localized(), for: .normal)
//                       self.orderProssesd.isHidden = true
                    case "order received to client":
                        self.orderProssesd.isHidden = true
                        
                    default:
                        self.orderStatus = "client confirmed".localized()
                    }
        }else{
            print("cccccccc false")

            switch self.currntOrderStatus {
             case "client refused":
                 print("hiii333333333")
            case "client confirmed":
             print("🌹\(self.currntOrderStatus)")
             self.orderStatus =  "order ready"
             self.orderProssesd.setTitle("order ready".localized(), for: .normal)
             case "provider accept":
                 self.orderProssesd.isHidden = false
             case "order ready":
                 self.orderStatus =  "delegate received"
                 self.orderProssesd.setTitle("delegate received".localized(), for: .normal)
                self.orderProssesd.isHidden = true
                 if !self.fristTime{
                    self.navigationController?.popViewController(animated: true)
                }

            case "on way":
           self.orderStatus =  "order received to client"
                 self.orderProssesd.setTitle("order received to client".localized(), for: .normal)
                self.orderProssesd.isHidden = true
            case "order received to client":
                  self.orderProssesd.isHidden = true
            default:
                self.orderStatus = "client confirmed"
                self.orderProssesd.isHidden = true
                self.orderProssesd.setTitle("client confirmed".localized(), for: .normal)
            }
        }

    }
    
    func ShowProduct(user_id:String,order_id:String){
        self.startAnimating()
        let params: Parameters = [
            "user_id": user_id,
            "lang":getServerLang(),
            "order_id":order_id
        ]
        print("🌼\(params)")
        API.POST(url: ShowProduct_Url, parameters: params, headers: nil) { (success, value) in
            if success{
                self.stopAnimating()
                let data = value["data"] as! [String:Any]
                let order_created_at = data["order_created_at"] as! String
                let order_user_name = data["order_user_name"] as! String
                let order_user_city = data["order_user_city"] as! String
                let total_price = data["total_price"] as! Int
                let order_user_avatar = data["order_user_avatar"] as! String
                let order_status = data["order_status"] as! String
                self.currentStatuse = order_status
                if self.currentStatuse == "order ready"{
                    self.orderProssesd.backgroundColor = .red
                }else{
                    
                }
                
                let order_user_lat = data["order_user_lat"] as! String
                self.client_lat = order_user_lat
                let providerLat =  data["order_provider_lat"] as? String
                let providerLong =  data["order_provider_lng"] as? String
                self.provider_lat = providerLat!
                self.provider_lng = providerLong!
                let order_user_lng = data["order_user_lng"] as! String
                self.client_lng = order_user_lng
             

                let order_have_delegate = data["order_have_delegate"] as! String
                let order_id = data["order_id"] as! Int
                let prodctorder = data["order_products"] as! [[String:Any]]
                self.net_price =  data["net_price"] as? Double ?? 0.0
                self.provider_commision =  data["provider_commission"] as? Double ?? 0.0
                
                var additions = [proudctAddtionsOrderModel]()
                let orderprod = OrderProductsModel()
                self.orderHaveDelgate = order_have_delegate
                self.currntOrderStatus = order_status
                self.orderProssesd.setTitle(order_status, for: .normal)
                for i in 0..<prodctorder.count{
                    additions = []
//                    if let product_additions = prodctorder[i]["product_additions"] as? [[String:Any]]{
//                        for pa in product_additions{
//                            let addition_id = pa["addition_id"] as! Int
//                            let addition_name = pa["addition_name"] as! String
//                            let addition_count = pa["addition_count"] as! Int
//                            let addition_price = pa["addition_price"] as! Int
//                            additions.append(proudctAddtionsOrderModel(addition_id: addition_id, addition_name: addition_name, addition_price: addition_price, addition_count: addition_count))  }
//                    }

                    orderprod.product_count = prodctorder[i]["product_count"] as! Int
                    orderprod.product_price = prodctorder[i]["product_price"] as! Int
                    orderprod.product_id = prodctorder[i]["product_id"] as! Int
                    orderprod.product_name = prodctorder[i]["product_name"] as! String
                    orderprod.Total_price = data["total_price"] as! Int
                    orderprod.product_additions = additions
//                    self.OrderProudct.append(orderprod)
                    self.CheackOrderStatus()
//                    print("💛🌸💕\(orderprod.product_additions)")
                    self.tableView.reloadData()

                }
                
                
                
                self.userName.text = order_user_name
                self.userLocation.text = "City".localized() + " : " + order_user_city
                self.orderId.text = "Order Number".localized() + " : " + String(describing: order_id)
                self.orderTime.text = "Order Time".localized() + " : " + order_created_at
                self.orderImage.setImageWith(order_user_avatar)
                self.DrawAnnotion(lat:Double(order_user_lat)! , Lng: Double(order_user_lng)!)
                
                
                
                print("🌼\(value)")
            }
        }
    }
    
    func DrawAnnotion(lat:Double,Lng:Double){
        print(lat, Lng, "mmmmmmmmmmmmm  11")
        let annotation = ImageAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(Lng))
        annotation.annotationImage = #imageLiteral(resourceName: "locationclient")
        annotation.isClicked = false
        mapView?.addAnnotation(annotation)
        let mapCamera = MKMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 1000, pitch: 65, heading: 0)
        mapView?.setCamera(mapCamera, animated: true)

       // mapView.showAnnotations([annotation], animated: false)

     //   mapView.showAnnotations([annotation], animated: true)
    }
    
}
extension MyOrdersDetilsViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Alert.showAlertOnVC(target: self, title: "تأكد من فتح ال GPS", message: "")
    }
}
extension MyOrdersDetilsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        if annotation.isKind(of: ImageAnnotation.self) {
            
            var view: ImageAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation") as? ImageAnnotationView
            if view == nil {
                view = ImageAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
                
            }
            
            let annotation = annotation as! ImageAnnotation
            view?.annotationImgView.image = annotation.annotationImage
            view?.annotaionLbl.setTitle(annotation.title, for: .normal)
            view?.annotation = annotation
            
            return view
        }else{
            
        }
        return nil
    }
}



//MARK:- Networking
extension MyOrdersDetilsViewController: NetworkingHelperDeleget {
    func onHelper(getData data: DataResponse<String>, fromApiName name: String, withIdentifier id: String) {
        if id == LOGIN { handelOrderDataResponse(response: data) }
    }
    
    func onHelper(getError error: String, fromApiName name: String, withIdentifier id: String) {
        ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
    }
    
    // MARK:- request apis from server
    func requestOrderDataApi(user_id:String,order_id:String) {
        let params: Parameters = [
            "user_id": user_id,
            "lang":getServerLang(),
            "order_id":order_id
        ]
        
        NETWORK.connectWithHeaderTo(api: ShowProduct_Url, withParameters: params, andIdentifier: LOGIN, withLoader: true, forController: self, methodType: .post)
    }
    
    // MARK:- handle response server
        func handelOrderDataResponse(response: DataResponse<String>){
            self.stopAnimating()

        switch response.response?.statusCode {
        case 200:
              do{
                let login = try JSONDecoder().decode(orderDetailseModel.self, from: response.data ?? Data())
                switch login.status {
                case 1:
                    print("success")
                    self.OrderProudct = login.data?.order_products ?? []
                    if (login.data?.orderDeliveryTime?.isEarly ?? false){
                        isEarly = true
                    }else{
                         isEarly = false
                     }
                    if (login.data?.orderDeliveryTime?.isEarly ?? false){
                        orderTimeView.isHidden = false
                        timeLabel.text = login.data?.orderDeliveryTime?.deliveryTimeFormat
                    }else{
                        orderTimeView.isHidden = true
                    }
                    //SR
                    self.orderPriceLabel.text = "\(login.data?.total_price ?? 0) " + "SR".localized()
                    let perc = Double((login.data?.total_price ?? 0)) * 15.0 / 100.0
                    self.appMoneyLabel.text = "\(perc) " + "SR".localized()
                    let deleveryPrice = (login.data?.order_delivery_price ?? "0")
                    let dd = Double(deleveryPrice) ?? 0.0
                    
                    self.deliveryPrice.text = "\(deleveryPrice)" + "SR".localized()
                    
                    if login.data?.order_have_delegate == "no"{
                        self.deliverView.isHidden = true
                        self.totalPriceLabel.text = " \(login.data?.total_price ?? 0) " + "SR".localized()

                    }else{
                        print("\(Int(dd) ) ", (login.data?.total_price ?? 0), "mmmmmmmmkkbuyhvuytdfgh", deleveryPrice,  dd )
                        self.totalPriceLabel.text = "\((dd) + Double(login.data?.total_price ?? 0)) " + "SR".localized()
                    }
                    mainQueue {
                        self.tableViewHight.constant = (CGFloat(self.OrderProudct.count) * self.cellHieght) + CGFloat(100)

                         }
                    self.tableView.reloadData()
                case 0:
                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
                default:
                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
                }
            }catch let error{
                print(error,"mina")
                ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
            }
        default:
            ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
        }
    }

}
