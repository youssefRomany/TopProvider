//
//  CustomAnnotion.swift
//  Top12
//
//  Created by Sara Ashraf on 1/14/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class ImageAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var annotationImage: UIImage?
    var isClicked: Bool = false
    var viewTag: Int?
    
    override init() {
        self.coordinate = CLLocationCoordinate2D()
        self.title = nil
        self.annotationImage = nil
        self.viewTag = nil
    }
}

class ImageAnnotationView: MKAnnotationView {
    
    var backView = UIView()
    var annotationImgView = UIImageView()
    var annotaionLbl = UIButton()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 35)
        self.backView.frame = self.frame
        self.annotationImgView.frame = self.frame
        self.annotationImgView.isUserInteractionEnabled = true
        self.annotaionLbl.frame = CGRect(x: 0, y: 0, width: 100/1.7, height: 100/12)
        
        self.annotaionLbl.setTitleColor(UIColor.white, for: .normal)
        self.annotaionLbl.titleLabel?.font = UIFont(name: "Cairo-SemiBold", size: 11.5)
        self.annotaionLbl.isUserInteractionEnabled = true
        
        self.backView.backgroundColor = UIColor.clear
        self.backView.addSubview(self.annotationImgView)
        self.backView.addSubview(self.annotaionLbl)
        
        self.addSubview(self.backView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
