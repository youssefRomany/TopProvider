//
//  MyTabBAr.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/24/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import UIKit

import UIKit

class MyTabBAr: UITabBarController {
    
    @IBInspectable var defaultIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        styleTabBarController()
        selectedIndex = defaultIndex
        guard let tabItems = self.tabBar.items else { return }
       
        tabItems[0].image = #imageLiteral(resourceName: "home")
        tabItems[1].image = #imageLiteral(resourceName: "terms")
        tabItems[2].image = #imageLiteral(resourceName: "myproductsa")
        
        tabItems[0].selectedImage = #imageLiteral(resourceName: "home")
        tabItems[1].selectedImage = #imageLiteral(resourceName: "terms")
        tabItems[2].selectedImage = #imageLiteral(resourceName: "myproductsa")
        
        tabItems[0].title = "Home".localized()
        tabItems[1].title = "Bills".localized()
        tabItems[2].title = "My Products".localized()

    }
    
    func styleTabBarController(){
        self.tabBar.selectedImageTintColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 0, green: 0.8078431373, blue: 0.6784313725, alpha: 1)
        self.tabBar.barTintColor = UIColor.white
    }
    
    
}


//MARK:- UITabBar Controller Delegate
extension MyTabBAr: UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            if tabBarController.selectedIndex == 1 {
                //goNavigation(controllerId: "LoginViewController", controller: self)
                //pushToView(withId: "LoginViewController")
                print("ccccccccc")
//                self.navigationController?.popToRootViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
//                if let rootv = navigationController?.rootViewController { }
            

            }
    }
}
    

extension UINavigationController {
    var rootViewController : UIViewController? {
        return viewControllers.first
    }
}
