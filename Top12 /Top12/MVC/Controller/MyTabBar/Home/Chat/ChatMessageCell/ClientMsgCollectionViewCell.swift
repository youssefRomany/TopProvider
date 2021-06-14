//
//  ClientMsgCollectionViewCell.swift
//  Top12
//
//  Created by Sara Ashraf on 3/23/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit

class ClientMsgCollectionViewCell: UICollectionViewCell {
    
    
    
    var massage : clientMsgsModel! {
        didSet{
            name.text = massage.username
            time.text = massage.sent_at
            self.img.setImageWith(massage.avatar)
          
            if massage.type == "text"{
                msg.text = massage.msg
            }else{
                msg.text = massage.username + " sent Photo".localized()
            }
            
        }
    }
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellshadow()
        img.layer.cornerRadius = img.frame.height/2
        img.clipsToBounds = true
    }
    func cellshadow(){
        self.layer.applySketchShadow(color: UIColor.darkGray, alpha: 0.3, x: 0, y: 0, blur: 4, spread: 0)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
}
extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
