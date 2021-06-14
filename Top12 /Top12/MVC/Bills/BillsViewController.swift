//
//  BillsViewController.swift
//  Top12
//
//  Created by YoussefRomany on 4/29/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SideMenu


class BillsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!

    var bills: [Bills] = []
    var haveOpenBill = false

    ///Constant
    let NETWORK = NetworkingHelper()
    let SEARCH_ADS_LIST = "SEARCH_ADS_LIST"
    let NEW_BILL = "NEW_BILL"

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        self.menuBtn.image = #imageLiteral(resourceName: "menu")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        

        let name2 = Notification.Name("goToMsgs")
        self.tabBarController?.tabBar.isHidden = false
        UIApplication.shared.applicationIconBadgeNumber = 0

        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveMsg(_:)), name: name2, object: nil)
        if UserDefaults.standard.bool(forKey: "isMsg") {
            
            let vc =  Storyboard.Main.instantiate(ClientMessagesViewController.self)
            self.navigationController?.pushViewController(vc, animated: false)
            

        }
        requestNewBillsApi()

    }
    
    @objc func onDidReceiveMsg(_ notification:Notification) {
        
        let vc =  Storyboard.Main.instantiate(ClientMessagesViewController.self)
        self.navigationController?.pushViewController(vc, animated: false)
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

}




//MARK:- Helpers
extension BillsViewController{
    
    /// init view for first time
    func initView(){
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "Bills".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chat"), style: .done, target: self, action: #selector(openChat))

        NETWORK.deleget = self
        initCommonTableView()
//        requestBillsApi()

    }
    
    @objc func openChat(){
        print("hiii")
        let Reg = Storyboard.Main.instantiate(ClientMessagesViewController.self)
        self.navigationController?.pushViewController(Reg, animated: true)
    }
    
    /// init table view
    func initCommonTableView(){
        tableView.register(UINib(nibName: "billsTableViewCell", bundle: nil), forCellReuseIdentifier: "billsTableViewCell")
        tableView.estimatedRowHeight = 100
    }
    
//    /// get next page for the list
//     ///
//     /// - Parameter index: the current cell indexPath
//     func getNextPageAdsIfNeeded(fromIndex index: IndexPath) {
//         if index.row == searchResult.count - 1 && canLoadMoreAds{
//             page += 1
//             requestAdsListApi()
//         }
//     }
}


//MARK: - UITableView delegate and data source
 extension BillsViewController: UITableViewDelegate, UITableViewDataSource {
     
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height:CGFloat = 0.0004
         return height
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  bills.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "billsTableViewCell", for: indexPath) as! billsTableViewCell
        print("jjjjjjjj 66666666666", indexPath.row )
        if indexPath.row == 0{
            cell.titleBillLAbel.text = "دورة فوترية مفتوحه"
            cell.billNumberLabel.isHidden = true
            cell.billDate.text = "\("The session closing date".localized())  \(bills[indexPath.row].up_to_date ?? "")"
            print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjj", indexPath.row , bills[indexPath.row].up_to_date)
        }else{
            print("yyyyyyyy", indexPath.row )
            cell.billNumberLabel.isHidden = false
            cell.titleBillLAbel.text = "دورة فوترية مغلقه"
            cell.billNumberLabel.text = "\("Bill Number: ".localized()) \(bills[indexPath.row].id ?? 0)"
            cell.billDate.text = "\("Bill Date: ".localized()) \("From".localized()) \(bills[indexPath.row].start ?? "0" ) \("To".localized()) \(bills[indexPath.row].end ?? "")"
            cell.configCell(withBill: bills[indexPath.row])
        }
         return cell
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "BillsDetailsViewController") as! BillsDetailsViewController
        vc.bill = bills[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)

     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height:CGFloat = 110
         return height
     }
 }



//MARK:- Networking
extension BillsViewController: NetworkingHelperDeleget {
    func onHelper(getData data: DataResponse<String>, fromApiName name: String, withIdentifier id: String) {
        if id == NEW_BILL{
            handelNewBillsResponse(response: data)
        }else{
            handelBillsResponse(response: data)
        }
    }
    
    func onHelper(getError error: String, fromApiName name: String, withIdentifier id: String) {
        ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
    }
    
    // MARK:- request apis from server
    func requestBillsApi() {
        let params: Parameters = [
            "user_id": getUserID(),
        ]
        print(params, GET_BILLS )
        NETWORK.connectWithHeaderTo(api: GET_BILLS, withParameters: params, withLoader: true, forController: self, methodType: .post)
    }
    
    // MARK:- handle response server
        func handelBillsResponse(response: DataResponse<String>){
            self.stopAnimating()

        switch response.response?.statusCode {
        case 200:
              do{
                
                let resp = try JSONDecoder().decode(BillModel.self, from: response.data ?? Data())
                if resp.status == 200{
                    self.bills += resp.bills ?? []
                }else{
                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
                }
                mainQueue {
                    self.tableView.reloadData()
                }
                
            }catch let error{
                print(error,"mina")
                ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
            }
        default:
            ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
        }
    }
    
    // MARK:- request apis from server
    func requestNewBillsApi() {
        let params: Parameters = [
            "user_id": getUserID(),
        ]
        print(params, GET_BILLS )
        NETWORK.connectWithHeaderTo(api: "https://top12app.com/api/order/getOpenBill",withParameters: params, andIdentifier: NEW_BILL, withLoader: true, forController: self, methodType: .post)
    }
    
    // MARK:- handle response server
        func handelNewBillsResponse(response: DataResponse<String>){
            self.stopAnimating()

        switch response.response?.statusCode {
        case 200:
              do{
                let resp = try JSONDecoder().decode(BillModel.self, from: response.data ?? Data())
                if resp.status == 200{
                    self.bills = resp.bills ?? []
                    if resp.bills?.count > 0{
                        haveOpenBill = true
                    }
                    requestBillsApi()
                }else{
                    ShowErrorMassge(massge: "Error".localized(), title: "Error".localized())
                }
                mainQueue {
//                    self.tableView.reloadData()
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
public var screenWidth:CGFloat { get { return UIScreen.main.bounds.size.width } }
public var screenHeight:CGFloat { get { return UIScreen.main.bounds.size.height } }
