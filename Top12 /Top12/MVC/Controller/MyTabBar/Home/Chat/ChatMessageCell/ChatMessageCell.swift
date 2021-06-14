//
//  ChatMessageCell.swift
//  Top12
//
//  Created by Sara Ashraf on 3/23/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit
import UIKit
import SnapKit


class ChatMessageCell: UITableViewCell {
    
    
    var  userImage : UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.backgroundColor = UIColor.clear
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 20
        imageview.layer.borderWidth = 0.3
        imageview.image = #imageLiteral(resourceName: "user")
        return imageview
    }()
    var  msgImage : UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.backgroundColor = UIColor.clear
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 10
        
        return imageview
    }()
    let messagedate: UILabel  = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont(name: "Cairo-Regular", size: 10)
        date.textAlignment = .center
        date.textColor = UIColor.gray
        date.text = "10 صباحا"
        date.backgroundColor = UIColor.clear
        date.lineBreakMode = .byWordWrapping
        return date
    }()
    
    let messageLabel = UILabel()
    
    var userID = ""
    
    let bubbleBackgroundView = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    
    var massegeData : clientMsgsModel!{
        didSet {
            bubbleBackgroundView.backgroundColor = massegeData.user ==  userID ? #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1) :  UIColor.lightGray
            messageLabel.textColor =  massegeData.user ==  userID  ? UIColor.white :  UIColor.black
            messagedate.text = massegeData.sent_at
           
            self.userImage.setImageWith(massegeData.avatar)
            if massegeData.type == "text"{
                messageLabel.text = massegeData.msg
                msgImage.isHidden = true
                messageLabel.isHidden = false
                
            }else{
                messageLabel.isHidden = true
                msgImage.isHidden = false
                self.msgImage.setImageWith( massegeData.msg)
              
            }
            
            
            if massegeData.user ==  userID {
                cons1()
                
            } else {
                cons2()
                
            }
            
        }
        
    }
    
    override func prepareForReuse() {
        msgImage.isHidden = true
        messageLabel.isHidden = true
        messageLabel.text = ""
        msgImage.image = nil
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(userImage)
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        addSubview(messagedate)
        addSubview(msgImage)
        setupView()
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        userID = getUserID()
        
        backgroundColor = .clear
        
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.font = UIFont(name: "Cairo-Regular", size: 17)
        messageLabel.text = "We want to provide a longer string that is actually going to wrap onto the next line and maybe even a third line."
        messageLabel.numberOfLines = 0
        messageLabel.textColor = UIColor.black
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.selectionStyle = UITableViewCellSelectionStyle.none
        msgImage.isHidden = true
        messageLabel.isHidden = true
        
    }
    
    
    
    func cons1() {
        messageLabel.snp.remakeConstraints{
            (make) in
            make.top.equalTo(self.snp.top).offset(32)
            make.bottom.equalTo(self.snp.bottom).offset(-32)
            make.right.equalTo(self.snp.right).offset(-72)
            make.width.equalTo(200)
        }
        msgImage.snp.remakeConstraints{
            (make) in
            make.top.equalTo(self.snp.top).offset(32)
            make.right.equalTo(self.snp.right).offset(-72)
            make.bottom.equalTo(self.snp.bottom).offset(-32)
            make.width.equalTo(200)
            if massegeData.type == "image"{
                make.height.equalTo(150)
            }
            
        }
        
        bubbleBackgroundView.snp.remakeConstraints{
            (make) in
            
            if massegeData.type == "image"{
                make.top.equalTo(self.msgImage.snp.top).offset(-16)
                make.bottom.equalTo(self.msgImage.snp.bottom).offset(16)
                make.right.equalTo(self.msgImage.snp.right).offset(16)
                make.left.equalTo(self.msgImage.snp.left).offset(-16)
                
            }else{
                make.top.equalTo(self.messageLabel.snp.top).offset(-16)
                make.bottom.equalTo(self.messageLabel.snp.bottom).offset(16)
                make.right.equalTo(self.messageLabel.snp.right).offset(16)
                make.left.equalTo(self.messageLabel.snp.left).offset(-16)
            }
            
        }
        userImage.snp.remakeConstraints{
            (make) in
            make.top.equalTo(self.messageLabel.snp.top).offset(-16)
            make.right.equalTo(self.snp.right).offset(-5)
            make.width.equalTo(40)
            make.height.equalTo(40)
            
        }
        messagedate.snp.remakeConstraints{
            (make) in
            make.top.equalTo(self.messageLabel.snp.top).offset(-16)
            make.right.equalTo(self.bubbleBackgroundView.snp.left).offset(-2)
            make.left.equalTo(self.snp.left).offset(2)
            make.height.equalTo(40)
            
        }
    }
    
    func cons2() {
        messageLabel.snp.remakeConstraints{
            (make) in
            make.top.equalTo(self.snp.top).offset(32)
            make.bottom.equalTo(self.snp.bottom).offset(-32)
            make.left.equalTo(self.snp.left).offset(72)
            make.width.equalTo(200)
        }
        msgImage.snp.remakeConstraints{
            (make) in
            make.top.equalTo(self.snp.top).offset(32)
            make.left.equalTo(self.snp.left).offset(72)
            make.bottom.equalTo(self.snp.bottom).offset(-32)
            make.width.equalTo(200)
            if massegeData.type == "image"{
                make.height.equalTo(150)
            }
            
            
        }
        
        bubbleBackgroundView.snp.remakeConstraints{
            (make) in
            
            if massegeData.type == "image"{
                make.top.equalTo(self.msgImage.snp.top).offset(-16)
                make.bottom.equalTo(self.msgImage.snp.bottom).offset(16)
                make.right.equalTo(self.msgImage.snp.right).offset(16)
                make.left.equalTo(self.msgImage.snp.left).offset(-16)
                
            }else{
                make.top.equalTo(self.messageLabel.snp.top).offset(-16)
                make.bottom.equalTo(self.messageLabel.snp.bottom).offset(16)
                make.right.equalTo(self.messageLabel.snp.right).offset(16)
                make.left.equalTo(self.messageLabel.snp.left).offset(-16)
            }
        }
        userImage.snp.remakeConstraints{
            (make) in
            make.top.equalTo(self.messageLabel.snp.top).offset(-16)
            make.left.equalTo(self.snp.left).offset(5)
            make.width.equalTo(40)
            make.height.equalTo(40)
            
        }
        messagedate.snp.remakeConstraints{
            (make) in
            make.top.equalTo(self.messageLabel.snp.top).offset(-16)
            make.left.equalTo(self.bubbleBackgroundView.snp.right).offset(2)
            make.right.equalTo(self.snp.right).offset(-2)
            make.height.equalTo(40)
            
        }
    }
    
}
