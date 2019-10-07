//
//  ViewController.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/1/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signupButton: RoundedCornerButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .dark
        super.viewDidLoad()
        signupButtonSetup()
        loginButtonSetup()
        // Do any additional setup after loading the view.
    }
    
    private func loginButtonSetup() {
        loginButton.titleLabel?.font = UIConstants.ROBOTO_REGULAR
        loginButton.setTitleColor(UIConstants.IDENTAXY_PINK, for: .normal)
        loginButton.setTitleColor(UIConstants.IDENTAXY_LIGHT_PINK, for: .selected)
        loginButton.setTitleColor(UIConstants.IDENTAXY_LIGHT_PINK, for: .highlighted)
    }
    
    private func signupButtonSetup() {
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.layer.cornerRadius = 20 // override the radius. Make it pill shaped.
    }
}

