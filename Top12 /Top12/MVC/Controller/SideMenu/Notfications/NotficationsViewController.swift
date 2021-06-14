//
//  NotficationsViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/22/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit
class NotficationsViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var params:Dictionary = [String:Any]()
    var dataArray = NSMutableArray()
    
    var Notifcations = [NotficationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startAnimating()
        getNotifcation()
        configureMenuTableView()
        self.navigationController?.navigationBar.topItem?.title = ""
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title =  "Notfications".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotficationCellTableViewCell", for: indexPath) as! NotficationCellTableViewCell
        cell.notficationNumber.text = self.Notifcations[indexPath.section].msg
        cell.notficationMassge.text = self.Notifcations[indexPath.section].date
        cell.selectionStyle = .none
        cell.dropShadow()
        cell.notficationDelet.addTarget(self, action: #selector(deletNotfy), for: .touchUpInside)
        cell.notficationDelet.tag = self.Notifcations[indexPath.section].id!
        
        return cell
    }
    @objc func  deletNotfy(sender:UIButton){
        //self.startAnimating()
        print("🤩\(String(sender.tag))")
        let alert = UIAlertController(title: "", message: "Are you sure you want to delete this notification?".localized(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes".localized(), style: UIAlertActionStyle.default, handler: { action in
            self.startAnimating()
            self.deleteNotfication(notify_id: String(sender.tag), user_id: getUserID())
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No".localized(), style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.Notifcations[indexPath.section].type == "order" && self.Notifcations[indexPath.section].status == "1" ){
            let storyBoard : UIStoryboard = UIStoryboard(name: "ProviderHome", bundle:nil)
            let InstrcationsViewController = storyBoard.instantiateViewController(withIdentifier: "NewOrderDetilsViewController") as! NewOrderDetilsViewController
          //  InstrcationsViewController.OrderID = String(describing: self.Notifcations[indexPath.section].id)
            
            self.navigationController?.pushViewController(InstrcationsViewController, animated: true)
        }else if (self.Notifcations[indexPath.section].type == "book"){
            print("book")
        }else{
         //   let storyBoard : UIStoryboard = UIStoryboard(name: "ProviderHome", bundle:nil)
//            let InstrcationsViewController = storyBoard.instantiateViewController(withIdentifier: "ProviderOrderDetilseViewController") as! ProviderOrderDetilseViewController
//            InstrcationsViewController.orderId =  String(describing: self.Notifcations[indexPath.section].taggable_id)
//            InstrcationsViewController.currntOrderStatus = String(describing:  self.Notifcations[indexPath.section].status)
//
          //  self.navigationController?.pushViewController(InstrcationsViewController, animated: true)
        }
        
    }
    func configureMenuTableView(){
        tableView.register(UINib(nibName: "NotficationCellTableViewCell", bundle: nil), forCellReuseIdentifier: "NotficationCellTableViewCell")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.Notifcations.count
    }
    
    func getNotifcation(){
        ProviderBaseService.getNotfications(user_id: getUserID(), vc: self,completion: {
            (error: Error?, Notfications: [NotficationModel]?) in
            self.stopAnimating()
            if let Notfications = Notfications{
                self.Notifcations = Notfications
                self.tableView.reloadData()
                print("🌔🌒")
                
                print("🤩\(self.Notifcations.count)")
            }
        })
        
        
    }
    func deleteNotfication(notify_id:String,user_id:String){
        let params :Parameters = [
            "user_id":user_id,
            "notify_id":notify_id
        ]
        print("🌔🌒\(params)")
        API.POST(url: Delete_NotficationURL, parameters: params, headers: [:]) { (suceess, value) in
            if suceess{
                self.stopAnimating()
             print("🌔🌒\(value)")
                self.getNotifcation()
            }
        }
    }
}
