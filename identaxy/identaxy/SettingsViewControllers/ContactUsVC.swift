//
//  ContactUsVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class ContactUsVC: IdentaxyHeader {
    
    var delegate: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeaderTitle(title: "Contact Us")
        overrideUserInterfaceStyle = .dark
    }
    
}
