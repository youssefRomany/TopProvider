//
//  ImageDownloaderExtension.swift
//  BeepBeep
//
//  Created by Sara Ashraf on 11/20/18.
//  Copyright © 2018 Sara Ashraf. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageWith(_ linkString: String?)  {
        guard let linkString = linkString,
            let url = URL(string: linkString) else { return }
        self.kf.setImage(with: url)
    }
    
    func setImageWith(url: URL?) {
        guard let url = url else { return  }
        self.kf.setImage(with: url)
    }
}
