//
//  NewOrderDetilsViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/9/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import WebKit

import CoreLocation

extension NewOrderDetilsViewController{
        
        func runAuctionTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateReplayTimer)), userInfo: nil, repeats: true)
        }
        
        func stopAuctionTimer() {
            timer.invalidate()
        }
        
        @objc func updateReplayTimer() {
            if remainTime < 1 {
                stopAuctionTimer()
                self.counterLabel.text = "00:00"
                self.containerCounterView.isHidden = true
                self.attentionLabel.isHidden = true
                self.counterLabel.isHidden = true
                self.acceptButton.isHidden=true
                self.refuseButton.isHidden=true
                navigationController?.popViewController(animated: true)

                
            }else {
                remainTime -= 1000
                auctionTimeString(time: TimeInterval(remainTime))
            }
        }
        
        public func mainQueue(_ closure: @escaping ()->()){
            DispatchQueue.main.async(execute: closure)
        }
        
        func auctionTimeString(time: TimeInterval) {
            let intTime = Int(time)
            let sec = 1000
            let minute = sec * 60
            let hour = minute * 60
            let day = hour * 24
            
            let hours = self.remainTime / 3600
            let minutes = (self.remainTime - hours * 3600) / 60
            let second = (self.remainTime - minutes * 3600) / 60000

            
            let dayValue = Int(intTime/day)
            let hourValue = Int( (intTime%day) / hour)
            let minutesValue = Int((intTime%hour) / minute)
            let secondValue = Int((intTime%minute) / sec)
            mainQueue {
//                self.counterLabel.text = "\(hourValue):\(minutesValue):\(secondValue)"
                if secondValue > 9{
                    self.counterLabel.text = "0\(minutesValue):\(secondValue)"
                }else{
                    self.counterLabel.text = "0\(minutesValue):0\(secondValue)"
                }

    //            self.dayValueLabel.text = "\(dayValue)"
    //            self.hourValueLabel.text = "\(hourValue)"
    //            self.minutesValueLabel.text = "\(minutesValue)"
    //            self.secondValueLabel.text = "\(secondValue)"
            }
        
        }
}

class NewOrderDetilsViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate {
    
    var timestamp = NSDate().timeIntervalSince1970
    var quantity = 0
    var minBid = 0
    var lastDate = 0
    var timer = Timer()
    var remainTime: Int = 0
    var fromTime: Int = 0

    
    var net_price = 0.0
    var provider_commision = 0.0
    
    
    var client_lat = ""
    var client_lng = ""
    
    var provider_lat = ""
    var provider_lng = ""
    var cellHieght = CGFloat(150)
    
    var ProductId = ""
    var orderStatusFlag = ""
    var orderStatus = ""
    var currntOrderStatus = ""
    var orderHaveDelgate = ""

    
    @IBOutlet var tableViewHight: NSLayoutConstraint!
    
    @IBOutlet var deliverView: UIView!
    
//    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    
    
    @IBOutlet var orderTimeView: UIView!
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
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
    
    @IBOutlet var containerCounterView: UIView!
    @IBOutlet var counterLabel: UILabel!
    
    @IBOutlet var acceptButton: RoundedButton!
    @IBOutlet var refuseButton: RoundedButton!
    @IBOutlet var attentionLabel: UILabel!
    
    
    ///Constant
    let NETWORK = NetworkingHelper()
    let LOGIN = "login"

    @IBAction func shareLocationAction(_ sender: Any) {
        
        share(items: [URL(string:"http://maps.google.com/maps?saddr=\(52.033809),\(6.882286)")!], forController: self)
//        print(URL(string:"http://maps.google.com/maps?saddr=\(client_lat),\(client_lng)")!, "rrrrrrrrrrr")
        
//        if let shareObject = self.activityItems(latitude: 52.033809, longitude: 6.882286) {
//               //open UIActivityViewController
//            share(items: [shareObject], forController: self)
//            print(shareObject)
//        }
    }
    
//    func activityItems(latitude: Double, longitude: Double) -> [AnyObject]? {
//            var items = [AnyObject]()
//
//            let URLString = "https://maps.apple.com?ll=\(latitude),\(longitude)"
//
//            if let url = NSURL(string: URLString) {
//                items.append(url)
//            }
//
//            let locationVCardString = [
//                "BEGIN:VCARD",
//                "VERSION:3.0",
//                "PRODID:-//Joseph Duffy//Blog Post Example//EN",
//                "N:;Shared Location;;;",
//                "FN:Shared Location",
//                "item1.URL;type=pref:\(URLString)",
//                "item1.X-ABLabel:map url",
//                "END:VCARD"
//            ].joined(separator: "\n")
//
//            guard let vCardData : NSSecureCoding = locationVCardString.data(using: .utf8) as NSSecureCoding? else {
//                return nil
//            }
//
//            let vCardActivity = NSItemProvider(item: vCardData, typeIdentifier: kUTTypeVCard as String)
//
//            items.append(vCardActivity)
//
//            return items
//        }
    
    func share(items:[Any], forController controller:UIViewController, excludedActivityTypes types:[UIActivity.ActivityType]? = nil) {
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = controller.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = types
        
        // present the view controller
        controller.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func AgreeOrder(_ sender: Any) {

        self.startAnimating()
        self.changeState(order_id: self.OrderID, status: "accept", user_id: getUserID(), shop_delegate: "", delegate_price: "")

        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CustomDelgateAlertViewController") as! CustomDelgateAlertViewController
//        vc.orderID = self.OrderID
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//
//        self.addChildViewController(vc)
//        self.view.addSubview(vc.view)
    }
   // ["shop_delegate": "", "order_id": "457", "status": "refuse", "delegate_price": "", "lang": "ar", "user_id": "585"] jjjjjjjj

    
    @IBAction func RefuseOrder(_ sender: Any) {
        self.startAnimating()
        self.changeState(order_id: self.OrderID, status: "refuse", user_id: getUserID(), shop_delegate: "", delegate_price: "")
    }
    
    var OrderProudct = [joeOrder_products]()
    var OrderID = ""
    var orderNumber = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuTableView()
        NETWORK.deleget = self
        self.mapView.cornerRadius = 5
        self.orderImage.image = #imageLiteral(resourceName: "logo")
        self.orderImage.layer.cornerRadius = 35
        self.orderImage.layer.borderWidth = 1
        self.orderImage.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = ""
        print("🌝\(self.orderNumber)","dweiodjwiuehduwiehdiuwhediuwehdi")
        self.startAnimating()
        mapView.delegate = self
        self.tableView.showsVerticalScrollIndicator = false
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)

        //self.tableHeight.constant = 300
        
    }
    @objc func appMovedToBackground() {
        print("App moved to ForeGround!")
        self.requestOrderDataApi(user_id: getUserID(), order_id: self.ProductId)

    }
    
    override func viewWillAppear(_ animated: Bool) {
       self.requestOrderDataApi(user_id: getUserID(), order_id: self.ProductId)
        self.tabBarController?.tabBar.isHidden = true
        if(orderStatusFlag == "refused"){
//            self.orderProssesd.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        print("fffffffffrofij34oifj3roifjroferjiferjfioer")
    }
    
    @IBAction func openLocationInGoogleMaps(_ sender: Any) {
        
        print(self.client_lat,self.client_lng, "mmmmmmmmmmmmm  11")
        print(self.provider_lat,self.provider_lng, "mmmmmmmmmmmmm  11")

        if (UIApplication.shared.canOpenURL(URL(string:"https://")!)) {
//            UIApplication.shared.open(URL(string:"https://maps.google.com//?saddr=\(self.provider_lat),\(self.provider_lng)&daddr=\(self.client_lat),\(self.client_lng)&directionsmode=transit")!, options: [:], completionHandler: nil)
            UIApplication.shared.open(URL(string:"http://maps.google.com/maps?saddr=\(client_lat),\(client_lng)")!, options: [:], completionHandler: nil)

         //   http://maps.google.com/maps?saddr=21.59260885328216,39.16562911123037
//            print("mmmmmmmmmmmmmmmmmm  ", "https://maps.google.com//?saddr=\(self.provider_lat),\(self.provider_lng)&daddr=\(self.client_lat),\(self.client_lng)&directionsmode=driving")
        } else {
            print("Can't use comgooglemaps://")
        }
        

//        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
//        {
//            UIApplication.shared.open(NSURL(string: "comgooglemaps://?saddr=&daddr=\(String(describing: Float(self.client_lat))),\(String(describing: Float(self.client_lng)))&directionsmode=driving")! as URL)
//        } else {
//
////            let url = "https://www.google.com/maps?daddr=\(self.client_lat),\(self.client_lng)"
////            ESOpen(url: URL(string: url) ?? URL(fileURLWithPath: ""))
//
////            let alert = UIAlertController.init(title: localizedSitringFor(key: "Attention"), message: localizedSitringFor(key: "GoogleMaps not available"), preferredStyle: UIAlertController.Style.alert)
////
////            alert.addAction(UIAlertAction(title: localizedSitringFor(key: "dismiss"), style: UIAlertAction.Style.default, handler: nil))
////            self.present(alert, animated: true, completion: nil)
//
//        }
    }
    
    
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
    
    func ShowProduct(user_id:String,order_id:String){
        let params: Parameters = [
            "user_id": user_id,
            "lang":getServerLang(),
            "order_id":order_id
        ]
        print("🌼\(params)")
        API.POST(url: ShowProduct_Url, parameters: params, headers: nil) { (success, value) in
            if success{
                print(ShowProduct_Url)
                self.stopAnimating()
                let data = value["data"] as! [String:Any]
                let order_created_at = data["order_created_at"] as! String
                let order_user_name = data["order_user_name"] as! String
                let order_user_city = data["order_user_city"] as! String
                let order_have_delegate = data["order_have_delegate"] as! String
                let total_price = data["total_price"] as! Int
                let order_user_avatar = data["order_user_avatar"] as! String
                let order_user_lat = data["order_user_lat"] as! String
                 self.client_lat = order_user_lat
                self.provider_lat = data["order_provider_lat"] as! String
                let order_user_lng = data["order_user_lng"] as! String
                self.client_lng = order_user_lng
                self.provider_lng = data["order_provider_lng"] as! String

                let order_id = data["order_id"] as! Int
                let prodctorder = data["order_products"] as! [[String:Any]]
                self.net_price =  data["net_price"] as! Double
                self.provider_commision =  data["provider_commission"] as! Double
                
                
                /// jooooooooooooooooooo
                let timeeee = Int(order_created_at) ?? 0
                self.lastDate = Int(timeeee) ?? 0
                print(timeeee, "timeeee", order_created_at)
                let diff =  Double(self.lastDate) - self.timestamp
                print(diff, "rrrrrrrrrr")
                print("lastDate",self.lastDate,  "timestamp",self.timestamp,  "diff", diff)

                self.remainTime = Int(diff * 1000)
                
                if diff > 0{
                    print(diff, "rrrrrinnnnnnnnn")
                        self.mainQueue {
                            self.stopAuctionTimer()
                            self.runAuctionTimer()
                        }
                }else{
                    self.containerCounterView.isHidden = true
                    self.attentionLabel.isHidden = true
                    self.acceptButton.isHidden=true
                    self.refuseButton.isHidden=true
                    
                    

                }
                    
                var additions = [proudctAddtionsOrderModel]()
                let orderprod = OrderProductsModel()
                for i in 0..<prodctorder.count{
                    additions = []
                    if let product_additions = prodctorder[i]["product_additions"] as? [[String:Any]]{
                        for pa in product_additions{
                            let addition_id = pa["addition_id"] as! Int
                            let addition_name = pa["addition_name"] as! String
                            let addition_count = pa["addition_count"] as! Int
                            let addition_price = pa["addition_price"] as! Int
                            additions.append(proudctAddtionsOrderModel(addition_id: addition_id, addition_name: addition_name, addition_price: addition_price, addition_count: addition_count))  }
                    }
                    
                    orderprod.product_count = prodctorder[i]["product_count"] as! Int
                    orderprod.product_price = prodctorder[i]["product_price"] as! Int
                    orderprod.Total_price = data["total_price"] as! Int
                    orderprod.product_id = prodctorder[i]["product_id"] as! Int
                    orderprod.product_name = prodctorder[i]["product_name"] as! String
                    orderprod.product_additions = additions
                    
//                    self.OrderProudct.append(orderprod)
//                    self.OrderProudct.insert(orderprod, at: i)
                    self.tableView.reloadData()

                    print("💛🌸💕\(self.OrderProudct[0].product_price) ,\(orderprod.product_price) llllllllllmmmmmmm")
                    print("💛🌸💕\(self.OrderProudct[i].product_price),\(orderprod.product_price)  llllllllllmmmmmmm")
                }
                print("💛🌸💕\(self.OrderProudct[0].product_price)  llllllllll")
                print("💛🌸💕\(self.OrderProudct[1].product_price)  llllllllll")

                self.mainQueue {
                    self.tableViewHight.constant = CGFloat(self.OrderProudct.count * 80)

                }
                
                
                self.userName.text = order_user_name
                self.OrderID = String(describing: order_id)
                self.userLocation.text = "City".localized() + " : " + order_user_city
                self.orderId.text = "Order Number".localized() + " : " + String(describing: order_id)
                self.orderNumber = String(describing: order_id)
                self.navigationItem.title = "Order Number".localized() + " : " + self.orderNumber
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
                
                self.orderTime.text = "Order Time".localized() + " : " + order_created_at
                self.orderImage.setImageWith(order_user_avatar)
                self.DrawAnnotion(lat:Double(order_user_lat)! , Lng: Double(order_user_lng)!)
                
                
                print("🌼\(value)")
            }
        }
    }
  
    func changeState(order_id:String,status:String,user_id:String,shop_delegate:String,delegate_price:String){
        let params: Parameters = [
            "order_id":order_id,
            "lang":getServerLang(),
            "status":status,
            "user_id":user_id,
            "shop_delegate":shop_delegate,
            "delegate_price":delegate_price
        ]
        Alamofire.request(RacceptOrRefuse_URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                self.stopAnimating()
                let json = JSON(data)
                let status = json["status"].int
                let msg = json["msg"].string
                if(status == 1){
                    ShowTrueMassge(massge: msg!, title: "Succss".localized())
                  
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of
                      self.navigationController?.popToRootViewController(animated: true)
                    }
                }else{
                    ShowErrorMassge(massge: msg ?? "", title: "Error".localized())
                }
            case .failure(_):
                print("faild")
                self.stopAnimating()
                print("😼\(response.error)")
            }
        }
        
    }
    
    
    func DrawAnnotion(lat:Double,Lng:Double){
        print(lat, Lng, "mmmmmmmmmmmmm  notation")

//        let annotation = ImageAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(Lng))
//        annotation.annotationImage = #imageLiteral(resourceName: "locationclient")
//        annotation.isClicked = false
//        mapView?.addAnnotation(annotation)
//        mapView.showAnnotations([annotation], animated: true)
        
        // Show artwork on map
        let artwork = Artwork(
          title: "",
          locationName: "",
          discipline: "",
          coordinate: CLLocationCoordinate2D(latitude: lat, longitude: Lng))
        
            mapView.addAnnotation(artwork)
        
        let oahuCenter = CLLocation(latitude: lat, longitude: Lng)
        let region = MKCoordinateRegionMakeWithDistance(
            oahuCenter.coordinate,
            60000,
            60000)
        if #available(iOS 13.0, *) {
            mapView.setCameraBoundary(
                MKMapView.CameraBoundary(coordinateRegion: region),
                animated: true)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 400000)
            mapView.setCameraZoomRange(zoomRange, animated: true)
        } else {
            // Fallback on earlier versions
        }

    }
}
    
extension NewOrderDetilsViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Alert.showAlertOnVC(target: self, title: "تأكد من فتح ال GPS", message: "")
    }
}
    
extension NewOrderDetilsViewController: MKMapViewDelegate {
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



public func mainQueue(_ closure: @escaping ()->()){
    DispatchQueue.main.async(execute: closure)
}


//MARK:- Networking
extension NewOrderDetilsViewController: NetworkingHelperDeleget {
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
                    self.tableView.reloadData()
                    mainQueue {
                        self.tableViewHight.constant = CGFloat(self.OrderProudct.count) * self.cellHieght

                         }
                    if (login.data?.orderDeliveryTime?.isEarly ?? false){
                        orderTimeView.isHidden = false
                        attentionLabel.text = "لن يتم تطبيق عمولة التطبيق في حالة انتهاء وقت القبول او رفضه"
                        attentionLabel.textColor = UIColor(hexString: "1E9581")
                        timeLabel.text = login.data?.orderDeliveryTime?.deliveryTimeFormat
                    }else{
                        orderTimeView.isHidden = true
                    }

                    self.userName.text = login.data?.order_user_name ?? ""
                    self.OrderID = String(describing: login.data?.order_id ?? 0)
                    self.userLocation.text = "City".localized() + " : " + (login.data?.order_user_city ?? "")
                    self.orderId.text = "Order Number".localized() + " : " + String(describing: login.data?.order_id ?? 0)
                    self.orderNumber = String(describing: login.data?.order_id ?? 0)
                    self.navigationItem.title = "Order Number".localized() + " : " + self.orderNumber
                    let timeeee = Int(login.data?.order_created_at ?? "0") ?? 0
                    
                    self.lastDate = Int(timeeee)
                    self.timestamp = NSDate().timeIntervalSince1970

                    let diff =  Double(self.lastDate) - self.timestamp
                    print(diff, "rrrrrrrrrr")
                    print("lastDate",self.lastDate,  "timestamp",self.timestamp,  "diff", diff)

                    self.remainTime = Int(diff * 1000)
                    
                    if diff > 0{
                        print(diff, "rrrrrinnnnnnnnn")
                            self.mainQueue {
                                self.stopAuctionTimer()
                                self.runAuctionTimer()
                            }
                    }else{
                        self.containerCounterView.isHidden = true
                        self.attentionLabel.isHidden = true
                        self.acceptButton.isHidden=true
                        self.refuseButton.isHidden=true

                    }
                    
                    if login.data?.order_status != "user waiting" {
                        self.containerCounterView.isHidden = true
                        self.attentionLabel.isHidden = true
                        self.acceptButton.isHidden=true
                        self.refuseButton.isHidden=true

                    }

                    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
                    let dddd = TimeInterval(login.data?.order_created_at ?? "") ?? 00000000
//                    let date = NSDate(timeIntervalSince1970: (dddd))
                    let date = Date(timeIntervalSince1970: dddd)
                    let formatterEn = DateFormatter()
                    formatterEn.dateFormat = "yyyy-MM-dd"
                    formatterEn.locale = Locale(identifier: "en")
                    let resultEn = formatterEn.string(from: date)

                    self.orderTime.text = "Order Time".localized() + " : \(resultEn)"
                    self.orderImage.setImageWith(login.data?.order_user_avatar ?? "")
                    mainQueue {
                        self.DrawAnnotion(lat:Double(login.data?.order_user_lat ?? "0")! , Lng: Double(login.data?.order_user_lng ?? "0")!)
                    }
                    
                     self.client_lat = login.data?.order_user_lat ?? "0"
                    self.client_lng = login.data?.order_user_lng ?? "0"
                    self.provider_lat =  login.data?.order_provider_lat ?? "0"
                    self.provider_lng = login.data?.order_provider_lng ?? "0"

                    
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


class Artwork: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}
