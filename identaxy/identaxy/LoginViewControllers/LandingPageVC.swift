//
//  ViewController.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/1/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LandingPageVC: IdentaxyHeader {

    @IBOutlet weak var signupButton: PillShapedButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        overrideUserInterfaceStyle = .dark
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButtonSetup()
        UserDefaults.standard.set(true, forKey:"darkModeOn")        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func loginButtonSetup() {
        loginButton.titleLabel?.font = UIConstants.ROBOTO_REGULAR
        loginButton.setTitleColor(UIConstants.IDENTAXY_PINK, for: .normal)
        loginButton.setTitleColor(UIConstants.IDENTAXY_LIGHT_PINK, for: .selected)
        loginButton.setTitleColor(UIConstants.IDENTAXY_LIGHT_PINK, for: .highlighted)
    }
}

