//
//  MyPocketViewController.swift
//  Top12
//
//  Created by YoussefRomany on 5/2/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MyPocketViewController: UIViewController {

    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var logoView: UIImageView!
    @IBOutlet var moneyTextField: UITextField!
    
    let NETWORK = NetworkingHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoView.image = #imageLiteral(resourceName: "logo")
        NETWORK.deleget = self


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        getShopData()

    }

    
    @IBAction func shippingAction(_ sender: Any) {
        if moneyTextField.text != ""{
            requestBillsApi()
        }else{
        ShowErrorMassge(massge: "You must Complate your Data".localized(), title: "Error".localized())

        }
    }
    
    @IBAction func payAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(RegisterBillsDataViewController.self)
        self.navigationController?.pushViewController(Home, animated: false)

    }
    
}


//MARK:- helpers
extension MyPocketViewController{
    
    
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
                let data = value["data"] as! [String:Any]
                let shop_balance = data["shop_balance"] as! String
                self.balanceLabel.text = "\(shop_balance) " + "SR".localized()
                
            }
        }
        
    }
}



//MARK:- Networking
extension MyPocketViewController: NetworkingHelperDeleget {
    func onHelper(getData data: DataResponse<String>, fromApiName name: String, withIdentifier id: String) {
       handelBillsResponse(response: data)
    }
    
    func onHelper(getError error: String, fromApiName name: String, withIdentifier id: String) {
        ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
    }
    
    // MARK:- request apis from server
    func requestBillsApi() {
        self.startAnimating()

        let mount = (moneyTextField.text ?? "")//.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        NETWORK.connectWithHeaderTo(api: "https://top12app.com/api/chargeStore?amount=\(mount.replacedArabicDigitsWithEnglish)&shop_id=\(getShopId())", withLoader: true, forController: self, methodType: .post)
        print("eeeeeeee"   ,"https://top12app.com/api/chargeStore?amount=\(mount)&shop_id=\(getShopId())")

    }
    
    // MARK:- handle response server
        func handelBillsResponse(response: DataResponse<String>){
            self.stopAnimating()

        switch response.response?.statusCode {
        case 200:
              do{
                let resp = try JSONDecoder().decode(TransactionModel.self, from: response.data ?? Data())
                let vc =  Storyboard.Main.instantiate(WebViewController.self)
                vc.urlLink = resp.transaction?.url ?? ""
                vc.transitionId = resp.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)

                if resp.status == "200"{

                }else{
//                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
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

public extension String {

public var replacedArabicDigitsWithEnglish: String {
    var str = self
    let map = ["٠": "0",
               "١": "1",
               "٢": "2",
               "٣": "3",
               "٤": "4",
               "٥": "5",
               "٦": "6",
               "٧": "7",
               "٨": "8",
               "٩": "9"]
    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
    return str
}
}
