//
//  ViewController.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/1/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class LandingPageVC: UIViewController {

    @IBOutlet weak var signupButton: PillShapedButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .dark
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButtonSetup()
    }
    
    private func loginButtonSetup() {
        loginButton.titleLabel?.font = UIConstants.ROBOTO_REGULAR
        loginButton.setTitleColor(UIConstants.IDENTAXY_PINK, for: .normal)
        loginButton.setTitleColor(UIConstants.IDENTAXY_LIGHT_PINK, for: .selected)
        loginButton.setTitleColor(UIConstants.IDENTAXY_LIGHT_PINK, for: .highlighted)
    }
    
}

