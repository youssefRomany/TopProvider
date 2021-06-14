//
//  ReArrangeViewController.swift
//  Top12
//
//  Created by YoussefRomany on 4/12/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReArrangeViewController: UIViewController {

    @IBOutlet var priceLAbel: UILabel!
    
    @IBOutlet var counterLAbel: UILabel!
    
    @IBOutlet var payButton: RoundedButton!
    
    var quantity = 0
    var minBid = 0
    var lastDate = 0
    var timer = Timer()
    var remainTime: Int = 0
    var fromTime: Int = 0
    var timestamp = NSDate().timeIntervalSince1970
    var canAddBid = true


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getBid()
//        let diff = Int(date2.timeIntervalSince1970 - date1.timeIntervalSince1970)
//        let hours = diff / 3600
//        let minutes = (diff - hours * 3600) / 60
//        print(hours, minutes, "rrrrr")
//        print("UTCDate", UTCDate.toString(dateFormat: "yyyy-MM-dd HH:mm:ss"))
//        print(UTCDate.timeIntervalSince1970)
        
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))

        print("timestamp=",timestamp,  "time=",time)
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)

            //self.tableHeight.constant = 300
            
        }
        @objc func appMovedToBackground() {
            print("App moved to ForeGround!")
            getBid()


        }
        
    
    @IBAction func pluseAction(_ sender: Any) {
        quantity += 5
        priceLAbel.text = "\(quantity)"
        
    }
    @IBAction func minusAction(_ sender: Any) {
        if quantity>10{
            quantity -= 5
            priceLAbel.text = "\(quantity)"

        }
    }
    @IBAction func payAction(_ sender: Any) {
        if quantity > minBid && canAddBid{
            
            setBid()
        }else{
            print("rrrrrrr")
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


//MARK:- Helpers
extension ReArrangeViewController{
    
    func runAuctionTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateReplayTimer)), userInfo: nil, repeats: true)
    }
    
    func stopAuctionTimer() {
        timer.invalidate()
    }
    
    @objc func updateReplayTimer() {
        if remainTime < 1 {
            stopAuctionTimer()
            self.counterLAbel.text = "00:00:00"
            canAddBid = true
            self.payButton.isHidden = false

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
            self.counterLAbel.text = "\(hourValue):\(minutesValue):\(secondValue)"

//            self.dayValueLabel.text = "\(dayValue)"
//            self.hourValueLabel.text = "\(hourValue)"
//            self.minutesValueLabel.text = "\(minutesValue)"
//            self.secondValueLabel.text = "\(secondValue)"
        }
    
    }
}

//MARK:- networking
extension ReArrangeViewController{
    
    
    func getBid(){
        API.POST(url: GET_HIEST_BID, parameters: ["lang":getServerLang(), "user_id": getUserID()], headers: nil) { (succeeded,value) in
            if succeeded {
                self.stopAnimating()
                let statuse = JSON(value["status"]!).int
                print("🥥\(value["highest"]), \(value["status"] )", statuse)
                if statuse == 200{
                    if let data = value["highest"] as? Int {
                        print(data, "mmmmmmmmmm")
                        self.priceLAbel.text = "\(data)"
                        self.quantity = data
                        self.minBid = data - 5
                        
                    }

                    self.timestamp = NSDate().timeIntervalSince1970
                    self.lastDate = value["last_date"] as? Int ?? 0
                    print("last_date", value["last_date"] as? Int ?? 0)
                    
                    let diff =  Double(self.lastDate) - self.timestamp
                    self.remainTime = Int(diff * 1000)
                    if diff > 0{
                        self.canAddBid = false
                        self.stopAuctionTimer()
                        self.runAuctionTimer()
                        self.payButton.isHidden = true
                    }else{
                        self.payButton.isHidden = false
                    }

                    
                }else {
                    if let msg = JSON(value)["msg"].string {
                        ShowErrorMassge(massge: msg, title: "Error".localized())
                        
                    }
                    
                }
                
            }else {
                self.stopAnimating()
            }
        }
        
    }
    
    
    
    func setBid(){
        self.stopAnimating()

        print("quantity", quantity)
        API.POST(url: SET_HIEST_BID, parameters: ["lang":getServerLang(), "user_id": getUserID(), "pid_value": quantity, "shop_id": getShopId()], headers: nil) { (succeeded,value) in
            if succeeded {
                let statuse = JSON(value["status"]!).int
                print("🥥\(value["highest"]), \(value["status"] )", statuse)
                if statuse == 200{
                    self.minBid = self.quantity
                    self.getBid()
                    ShowTrueMassge(massge: "Success".localized(), title: "")
                    if let data = value["highest"] as? Int {
                        ShowErrorMassge(massge: "Success".localized(), title: "")
                    }
                    
                }else {
                    if let msg = JSON(value)["msg"].string {
                        ShowErrorMassge(massge: msg, title: "Error".localized())
                        
                    }
                    
                }
                self.stopAnimating()
            }else {
                self.stopAnimating()
                self.stopAnimating()
            }
        }
        
    }
}


extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
