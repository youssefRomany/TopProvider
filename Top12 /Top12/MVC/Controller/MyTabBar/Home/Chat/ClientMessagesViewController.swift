//
//  ClientMessagesViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 3/24/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SwiftyJSON
import SideMenu
class ClientMessagesViewController: UIViewController {
    
    var user_id = ""
    var Msgs =  [clientMsgsModel]()
    
    
    let ScreenWidth = UIScreen.main.bounds.width
    let ScreenHeight = UIScreen.main.bounds.height

    
    @IBOutlet weak var emptyLbl: UILabel!
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var chatCollection: UICollectionView!
    let MyCollectionViewCellId: String = "ClientMsgCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "isMsg")
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationItem.title = "Chats".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        getMsgs()
    }
    func setView(){
        
        if UserDefaults.standard.string(forKey: "client_id") != nil {
            user_id = UserDefaults.standard.string(forKey: "client_id")!
        }else if UserDefaults.standard.string(forKey: "delegate_id") != nil {
            user_id = UserDefaults.standard.string(forKey: "delegate_id")!
        }else if UserDefaults.standard.string(forKey: "User_ID") != nil {
            user_id = UserDefaults.standard.string(forKey: "User_ID")!
        }
        
        menu.image = #imageLiteral(resourceName: "menu")
        if Language.currentLanguage() == "en"{
          //  backBtn.image = #imageLiteral(resourceName: "order_one")
            
        }else{
           // backBtn.image = #imageLiteral(resourceName: "back-1")
            
        }
        
        let nibCell = UINib(nibName: MyCollectionViewCellId, bundle: nil)
        chatCollection.register(nibCell, forCellWithReuseIdentifier: MyCollectionViewCellId)
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
    
    @IBAction func goBack(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
    func getMsgs(){
        self.Msgs.removeAll()
        self.startAnimating()
        API.GET(url: CLIENT_ALL_MSGS + getUserID() , completion: {
            ( succeeded: Bool,  result: [String: AnyObject]) in
            if succeeded {
               self.stopAnimating()
                let statuse = JSON(result["status"]!).int
                print("🥥\(result)")
                if statuse == 1{
                    if let data = result["data"] as? [[String: Any]] {
                        if data.count == 0 {
                            self.emptyLbl.isHidden = false
                        }else{
                            self.emptyLbl.isHidden = true
                            for msg in data {
                                self.Msgs.append(clientMsgsModel().getObject(dicc: msg))
                            }
                            self.chatCollection.reloadData()
                          //  AnimatableReload.reload(collectionView: self.chatCollection, animationDirection: "down")
                            
                        }
                        
                    }
                    
                }else {
                    if let msg = JSON(result)["msg"].string {
                        if self.user_id != "0" {
                            if self.user_id != "0" {
                               ShowErrorMassge(massge: msg, title: "")
                            }
                        }
                        
                    }
                    
                }
                
            }else {
                self.stopAnimating()
               
            }
        })
        
    }
}
extension ClientMessagesViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.Msgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCellId, for: indexPath) as! ClientMsgCollectionViewCell
        
        cell.massage = self.Msgs[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc =  Storyboard.Main.instantiate(ClientchatViewController.self)
        vc.msg = self.Msgs[indexPath.row]
        vc.order_id = self.Msgs[indexPath.row].order
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //---------------------size of cell
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: (ScreenWidth)-20, height: 110)
        
        
    }
    
}
