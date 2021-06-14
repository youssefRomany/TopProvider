//
//  UnderPreparedTableViewCell.swift
//  Top12
//
//  Created by YoussefRomany on 5/11/20.
//  Copyright © 2020 Sara Ashraf. All rights reserved.
//

import UIKit

class UnderPreparedTableViewCell: UITableViewCell {
    
    @IBOutlet var logoView: UIImageView!
    @IBOutlet var orderNumLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var containerCounterView: UIView!
    @IBOutlet var counterLabel: UILabel!
    
    var lastDate = 0.0
    var timer = Timer()
    var remainTime: Int = 0
    var fromTime: Int = 0
    var timestamp = NSDate().timeIntervalSince1970

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initCell(withOrder order:Final){
        orderNumLabel.text = "Order Number :".localized() + " " + String(describing: order.order_id ?? 0)
        cityLabel.text = order.order_city ?? ""
        logoView.layer.borderWidth = 1
        logoView.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)
        logoView.image = UIImage(named: "logo")
        print(order.order_status,"hhhkjwhkjfhwekjfhekjfhewkjfhwek")

        
        self.timestamp = NSDate().timeIntervalSince1970
        self.lastDate = Double(order.order_delivery_time ?? 0) ?? 0

        let diff =  Double(self.lastDate) - self.timestamp
        self.remainTime = Int(diff * 1000)
        print("remainTime=",remainTime, "diff=",diff , "lastDate=", lastDate, "created_at=",order.order_delivery_time ?? "777" )
        if diff > 0 && order.order_status != "order ready"{
            self.stopAuctionTimer()
            self.runAuctionTimer()
            mainQueue {
                self.containerCounterView.isHidden = false
            }
        }else{
            mainQueue {
                self.containerCounterView.isHidden = true
            }
        }
        
//        if order.order_status == "order ready"{
//            mainQueue {
//                self.containerCounterView.isHidden = true
//            }
//
//        }else{
////            mainQueue {
////                self.containerCounterView.isHidden = false
////            }
//        }


    }

    
}


extension UnderPreparedTableViewCell{
    
    func runAuctionTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateReplayTimer)), userInfo: nil, repeats: true)
    }
    
    func stopAuctionTimer() {
        timer.invalidate()
    }
    
    @objc func updateReplayTimer() {
        if remainTime < 1 {
            stopAuctionTimer()
            self.counterLabel.text = "00:00:00"
            mainQueue {
                self.containerCounterView.isHidden = true
            }

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
            self.counterLabel.text = "\(dayValue):\(hourValue):\(minutesValue):\(secondValue)"

//            self.dayValueLabel.text = "\(dayValue)"
//            self.hourValueLabel.text = "\(hourValue)"
//            self.minutesValueLabel.text = "\(minutesValue)"
//            self.secondValueLabel.text = "\(secondValue)"
        }
    
    }
}
