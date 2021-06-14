//
//  ProviderSideMenuViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/10/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SideMenu
import SwiftyJSON
class ProviderSideMenuViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    
    let menuTitles: [String] = ["Put me on top".localized(),"Add Proudct".localized(),"Bills".localized(),"Profile".localized(),"Evaluation".localized(),"Notfications".localized(),"Complains".localized(),"Call us".localized(),"About App".localized(),"Terms And Conditions".localized(),"Share App".localized(),"Setting".localized(),"Log out".localized()]
    
    let menuIcons = [UIImage(named: "send"),#imageLiteral(resourceName: "boxmenu"),UIImage(named: "billSideMenu"),#imageLiteral(resourceName: "homemenu"),#imageLiteral(resourceName: "profile"),#imageLiteral(resourceName: "notificationmenu"),#imageLiteral(resourceName: "reports"),#imageLiteral(resourceName: "contactus"),#imageLiteral(resourceName: "about"),#imageLiteral(resourceName: "terms"),#imageLiteral(resourceName: "share"),#imageLiteral(resourceName: "setting"),#imageLiteral(resourceName: "logout")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuTableView()
        self.userProfileImage.layer.cornerRadius = 70/2
        self.userProfileImage.clipsToBounds = true
        self.navigationController?.isNavigationBarHidden = true
        SideMenuManager.default.menuFadeStatusBar = false
        self.tableView.showsVerticalScrollIndicator = false
        self.userProfileImage.setImageWith(getUserAvatar())
        self.userName.text = getShopName()
    
    }
    
    func goToView(withId:String, andStoryboard story:String = "Main", fromController controller:UIViewController? = nil) {
        let board = UIStoryboard(name: story, bundle: nil)
        let control = controller ??  UIViewController()
        control.present(board.instantiateViewController(withIdentifier: withId), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return menuTitles.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderSideMenuTableViewCell", for: indexPath) as! ProviderSideMenuTableViewCell
      
            cell.menuTitle.text = menuTitles[indexPath.row]
            cell.menuIcon.image = menuIcons[indexPath.row]
            cell.selectionStyle = .none
        return cell
    }
    
    func configureMenuTableView(){
        tableView.register(UINib(nibName: "ProviderSideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "ProviderSideMenuTableViewCell")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
             print("ReArrangeViewController")
//            let Home = Storyboard.Main.instantiate(ReArrangeViewController.self)
//            self.performNavigation(view: Home)
            goToView(withId: "ReArrangeViewController",fromController: self)
            
        case 1:
            let Home = Storyboard.Main.instantiate(AddnewProductViewController.self)
            self.performNavigation(view: Home)
            
        case 2:
            print("bills")
            
            let Home = Storyboard.Main.instantiate(BillsViewController.self)
            self.performNavigation(view: Home)
        case 3:
//
             print("hhhh")
             //            defaults.set("add", forKey: UpdateOrAdd)
             let Home = Storyboard.Main.instantiate(ProfileViewController.self)
             self.performNavigation(view: Home)

        case 4:
            //            defaults.set("add", forKey: UpdateOrAdd)
            let Home = Storyboard.Main.instantiate(MyRateViewController.self)
            self.performNavigation(view: Home)
            print("hii")
            
        case 5:
//            defaults.set("add", forKey: UpdateOrAdd)
            let Home = Storyboard.Main.instantiate(NotficationsViewController.self)
            self.performNavigation(view: Home)
            print("hii")
        case 6:
            print("hhhh")
           let Home = Storyboard.Main.instantiate(ComplmintsViewController.self)
            self.performNavigation(view: Home)
            
        case 7:
             print("hhhh")
             let Home = Storyboard.Main.instantiate(ContactusViewController.self)
             self.performNavigation(view: Home)
            
        case 8:
             print("hhhh")
             let Home = Storyboard.Main.instantiate(ClientAboutUSViewController.self)
             self.performNavigation(view: Home)
            
        case 9:
             print("hhhh")
             let Home = Storyboard.Main.instantiate(TermsandConftionsViewController.self)
             defaults.set("terms", forKey: TermsFrom)
             self.performNavigation(view: Home)
            
        case 10:
            let firstActivityItem = "Top12"
            let secondActivityItem : NSURL = NSURL(string: "www.google.com")!
            // If you want to put an image
            //   let image : UIImage = UIImage(named: "matns")!
            
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            self.present(activityViewController, animated: true, completion: nil)
        case 11:
             print("hhhh")
            let Home = Storyboard.Main.instantiate(SettingViewController.self)
            self.performNavigation(view: Home)
            
        case 12:
            
            let alert = UIAlertController(title: "Log Out".localized(), message: "are you sure for LogOut".localized(), preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "OK".localized(), style:
                UIAlertActionStyle.default, handler:  { action in
                    self.startAnimating()
                    self.LogOut()
                    defaults.set("no", forKey: LoggedNow)
                    
            }))
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: UIAlertActionStyle.cancel, handler: nil))
            
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
                        

        default:
            break;
            
        }
    }
    func performNavigation(view: UIViewController!) {
        self.navigationController?.pushViewController(view!, animated: true)
    }
    func LogOut(){
        let params: Parameters = [
            "user_id":getUserID(),
            "device_id": AppDelegate.FCMTOKEN
        ]
        Alamofire.request(LogOut_URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["lang":getServerLang()]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                let json = JSON(data)
                let msg = json["msg"].stringValue
                
                self.stopAnimating()
                if response.result.value != nil{
                    defaults.set("no", forKey: LoggedNow)
                    print("😼\(response)")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // change 2 to desired number of
                        let Reg = Storyboard.Main.instantiate(LoginViewController.self)
                        
                        self.tabBarController?.tabBar.isHidden = true
                        self.navigationController?.pushViewController(Reg, animated: true)
                        
                    }
                    
                    
                    
                    
                    
                }
            case .failure(_):
                print("faild")
                print("😼\(response.error)")
                
                
            }
        }
        
    }
    
    
}
