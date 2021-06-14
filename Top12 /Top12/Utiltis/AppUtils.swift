//
//  AppUtils.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit

class AppUtils {
    static var object:AppUtils? = nil
    var curruntViewController = UIViewController()
    static func getObject() -> AppUtils {
        if (AppUtils.object == nil) {
            AppUtils.object = AppUtils()
        }
        return AppUtils.object!
    }
    
    
    func roundView(view:UIView, round:Int) {
        view.layer.cornerRadius = CGFloat(round)
        view.clipsToBounds = true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with:testStr)
    }
    func isValidMobileNumber(mobil : String) -> Bool {
        if mobil.count >= 8{
            return true
        }else {
            return false
        }
    }
    func isValidpassword(mobil : String) -> Bool {
        if mobil.count >= 6{
            return true
        }else {
            return false
        }
    }
    
    
    
    func isDeviceiPad() -> Bool {
        return (UIDevice.current.userInterfaceIdiom == .phone) ? false : true
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getNumberFormat(number:String) -> String {
        var someString = number
        if someString == "" {
            someString = "0"
        }
        let myInteger = Double(someString)
        let myNumber = NSNumber(value:myInteger!)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from:myNumber)
        return formattedNumber!
    }
    func setFont(label:UILabel, size:CGFloat, type:Int) {
        switch type {
        case 0:
            label.font = UIFont(name: "System Font Regular", size: size)
        case 1:
            label.font = UIFont(name: "HelveticaNeue", size: size)
        case 2:
            label.font = UIFont(name: "HelveticaNeue-Bold", size: size)
        default:
            label.font = UIFont(name: "HelveticaNeue", size: size)
        }
    }
    
    func getThumbnial(bigImage:UIImage) -> UIImage {
        var width:CGFloat = 0.0
        var height:CGFloat = 0.0
        if bigImage.size.width > 1024 {
            width = 1024
            let ratio = bigImage.size.width / width
            height = bigImage.size.height / ratio
        } else {
            width = bigImage.size.width
            height = bigImage.size.height
        }
        let originalImage = bigImage
        let destinationSize = CGSize.init(width: width, height: height)
        UIGraphicsBeginImageContext(destinationSize)
        originalImage.draw(in: CGRect.init(x: 0, y: 0, width: destinationSize.width, height: destinationSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func addBorderToBtn(button:UIButton) {
        button.layer.cornerRadius = 8
        button.layer.borderColor = (UIColor .lightGray).cgColor
        button.layer.borderWidth = 0.5
    }
    
    func validateNumber(str: String) -> String {
        var dotCounter = 0
        var string = str
        string  = string.replacingOccurrences(of: ",", with: "")
        for s in string {
            if s == "٠" {
                string.removeLast()
                string.append("0")
            } else if s == "١" {
                string.removeLast()
                string.append("1")
            } else if s == "٢" {
                string.removeLast()
                string.append("2")
            } else if s == "٣" {
                string.removeLast()
                string.append("3")
            } else if s == "٤" {
                string.removeLast()
                string.append("4")
            } else if s == "٥" {
                string.removeLast()
                string.append("5")
            } else if s == "٦" {
                string.removeLast()
                string.append("6")
            } else if s == "٧" {
                string.removeLast()
                string.append("7")
            } else if s == "٨" {
                string.removeLast()
                string.append("8")
            } else if s == "٩" {
                string.removeLast()
                string.append("9")
            } else if s != "0" && s != "1" && s != "2" && s != "3" && s != "4" && s != "5" && s != "6" && s != "7" && s != "8" && s != "9" && s != "." {
                string.removeLast()
            } else if s == "." {
                dotCounter += 1
            }
        }
        if dotCounter > 1 {
            string.removeLast()
        }
        //        string = getNumberFormat(number: string)
        return string
    }
    
    func getDateFromTimstamp(str:String) -> String {
        let date = Date(timeIntervalSince1970: Double(str)!)
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "en")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func makeShadow (view:UIView){
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 7
        view.layer.cornerRadius = 7
    }
    func makeAnimation (view:UIView) {
        UIView.animate(withDuration: 0.5) {
            view.layoutIfNeeded()
        }
    }
    
    
    func stringFromHtml(htmlString: String) -> NSAttributedString? {
        let htmlData = NSString(string: htmlString).data(using: String.Encoding.unicode.rawValue)
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        return attributedString
    }
    
    func removeSpacesFromUrl(url:String) -> String {
        let _url = url
        return _url.replacingOccurrences(of: " ", with: "%20")
    }
}
