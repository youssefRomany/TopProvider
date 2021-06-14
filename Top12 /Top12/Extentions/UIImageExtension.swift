//
//  UIImageExtension.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation

import UIKit

extension UIImage {
    
    func resizeImage(newSize: CGSize) -> UIImage {
        // resize image
        UIGraphicsBeginImageContext(CGSize(width: newSize.width, height: newSize.height))
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        newImage = newImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func convertBase64String(image: UIImage) -> String {
        // convert to base 64 string
        let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        let imageBase64String = imageData.base64EncodedString(options: .lineLength64Characters)
        return imageBase64String
    }
    
    func transform(withNewColor color: UIColor) -> UIImage {
        // trasform color of image
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        
        color.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

