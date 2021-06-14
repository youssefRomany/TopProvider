//
//  RegisterBillsDataViewController.swift
//  Top12
//
//  Created by YoussefRomany on 4/30/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire


class RegisterBillsDataViewController: UIViewController {

    @IBOutlet var accountNumberTF: UITextField!
    @IBOutlet var banckNameTF: UITextField!
    @IBOutlet var ibanNumTF: UITextField!
    @IBOutlet var moneyTF: UITextField!
    
    let NETWORK = NetworkingHelper()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "Data Register".localized()
        NETWORK.deleget = self
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        
        if(accountNumberTF.text?.isEmpty == true || banckNameTF.text?.isEmpty == true || ibanNumTF.text?.isEmpty == true || moneyTF.text?.isEmpty == true){
            ShowErrorMassge(massge: "You must Complate your Data".localized(), title: "Error".localized())
        }else{
            requestBillsApi()
        }
    }
    
}


//MARK:- Networking
extension RegisterBillsDataViewController: NetworkingHelperDeleget {
    func onHelper(getData data: DataResponse<String>, fromApiName name: String, withIdentifier id: String) {
       handelBillsResponse(response: data)
    }
    
    func onHelper(getError error: String, fromApiName name: String, withIdentifier id: String) {
        ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
    }
    
    // MARK:- request apis from server
    func requestBillsApi() {
        let params: Parameters = [
            "user_id": getUserID(),
            "shop_id": getShopId(),
            "lang":getServerLang(),
            "bank_account":accountNumberTF.text ?? "",
            "ipan_number":ibanNumTF.text ?? "",
            "bank_name":banckNameTF.text ?? "",
            "withdrawal_amount":moneyTF.text ?? "",
        ]
        
        print(params, GET_BILLS )
        self.startAnimating()
        NETWORK.connectWithHeaderTo(api: TRANSFER, withParameters: params, withLoader: true, forController: self, methodType: .post)
    }
    
    // MARK:- handle response server
        func handelBillsResponse(response: DataResponse<String>){
            self.stopAnimating()
            print(response.response?.statusCode, "mmmmmmmmm")
        switch response.response?.statusCode {
        case 200:
              do{
                let resp = try JSONDecoder().decode(BillModel.self, from: response.data ?? Data())
                if resp.status == 200{
                    ShowTrueMassge(massge: "تم استلام طلبكم لتسييل المبالغ".localized(), title: "Success".localized())
                    
                }else{
                    ShowErrorMassge(massge: "Your balance less than the valu you enterd".localized(), title: "Error".localized())
                }
                mainQueue {
                }
                
            }catch let error{
                print(error,"mina")
                ShowErrorMassge(massge: "Your balance less than the valu you enterd".localized(), title: "Error".localized())
            }
        case 410:
            ShowErrorMassge(massge: "Your balance less than the valu you enterd".localized(), title: "Error".localized())
        default:
            ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
        }
    }

}
