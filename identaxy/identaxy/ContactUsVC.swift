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

        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        // Setup 'Current' label.
        var pos = (screenWidth / 2) - (screenWidth / 4) + 30
        let current = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        current.center = CGPoint(x: pos, y: 90)
        current.textAlignment = .left
        current.text = "Email"
        self.view.addSubview(current)
                
        // Setup 'curEmail' label.
        pos = screenWidth - (screenWidth / 4) - 30
        let curEmail = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        curEmail.center = CGPoint(x: pos, y: 90)
        curEmail.textAlignment = .right
        curEmail.text = "foo@bar.com"
        self.view.addSubview(curEmail)
    }

}
