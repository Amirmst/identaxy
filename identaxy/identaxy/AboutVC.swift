//
//  AboutVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class AboutVC: IdentaxyHeader {
    
    var delegate: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.setHeaderTitle(title: "About")

        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        // Setup 'Current' label.
        var pos = (screenWidth / 2) - (screenWidth / 4) + 30
        let current = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        current.center = CGPoint(x: pos, y: 120)
        current.textAlignment = .left
        current.text = "Version"
        self.view.addSubview(current)
                
        // Setup 'curEmail' label.
        pos = screenWidth - (screenWidth / 4) - 30
        let curEmail = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        curEmail.center = CGPoint(x: pos, y: 120)
        curEmail.textAlignment = .right
        curEmail.text = "1.0"
        self.view.addSubview(curEmail)
        
        // Setup About Identaxy label.
//        pos = screenWidth - (screenWidth / 4) - 30
//        let curEmail = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
//        curEmail.center = CGPoint(x: pos, y: 120)
//        curEmail.textAlignment = .right
//        curEmail.text = "1.0"
//        self.view.addSubview(curEmail)
    }
    

}
