//
//  MyRateViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 4/4/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class MyRateViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate  {
    @IBOutlet weak var tableView: UITableView!
    var params:Dictionary = [String:Any]()
    var dataArray = NSMutableArray()
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRateTableViewCell", for: indexPath) as! MyRateTableViewCell
          let model = dataArray.object(at: indexPath.section) as! RateModel
        cell.UserImage.setImageWith(model.comment_user_img!)
        cell.UserName.text! = model.comment_username!
        cell.UserComment.text! = model.comment!
        cell.Date.text! = model.comment_date!
        cell.rateBar.value = CGFloat(Int(model.stars!)!)
        cell.UserImage.layer.cornerRadius = 120/2
        
        cell.UserImage.clipsToBounds = true
        cell.UserImage.cornerRadius = 30
       
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopAnimating()
        getRate()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func configureMenuTableView(){
        tableView.register(UINib(nibName: "MyRateTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRateTableViewCell")
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    func getRate(){
        params.updateValue(getUserID(), forKey: "user_id")
        params.updateValue(getServerLang(), forKey: "lang")
        Alamofire.request(Rate_Url, method: .post, parameters: params, encoding: JSONEncoding.default, headers:[:]).responseJSON{(response: DataResponse<Any>) in
            switch(response.result){
            case .success(let data):
                self.stopAnimating()
                print("😼\(response)")
                if response.result.value != nil{
                    
                    let data = ((response.result.value! as! NSDictionary).value(forKey: "data"))as! [String: Any]
                    let dataDic = data["comments"] as! [[String:Any]]
                    
                    for dic in dataDic {
                        
                        self.dataArray.add(RateModel().getObject(dicc: dic))
                        print("😆\(self.dataArray)")
                    }
                    
                    self.tableView.reloadData()
                }
            case .failure(_):
                print("faild")
                
            }
        }
        
    }
    
}
