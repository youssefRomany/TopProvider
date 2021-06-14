//
//  ProfileViewController.swift
//  Top12
//
//  Created by Sara Ashraf on 1/11/19.
//  Copyright © 2019 Sara Ashraf. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {
    @IBOutlet weak var storImage: UIImageView!
    
    @IBAction func personalAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(ProviderUserProfileViewController.self)
        self.navigationController?.pushViewController(Home, animated: false)
    }
    
    
    @IBAction func storeAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(StoreProfileViewController.self)
        self.navigationController?.pushViewController(Home, animated: false)
    }
    
    @IBAction func myPocketAction(_ sender: Any) {
        let Home = Storyboard.Main.instantiate(MyPocketViewController.self)
        self.navigationController?.pushViewController(Home, animated: false)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storImage.image = #imageLiteral(resourceName: "logo")
        self.storImage.setImageWith(getUserAvatar())
        self.storImage.layer.cornerRadius = 60
        self.storImage.clipsToBounds = true
        self.storImage.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.7843137255, blue: 0.6745098039, alpha: 1)

        self.storImage.layer.borderWidth = 2
        self.navigationItem.title = "Profile".localized()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Cairo-Regular", size: 16)!,NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }


}
