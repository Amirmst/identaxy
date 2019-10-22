//
//  SignupVC_Password.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/22/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class SignupVC_Password: UIViewController {

    @IBOutlet weak var passwordTextField: IdentaxyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .dark
        setupPasswordTextField()
        passwordTextField.becomeFirstResponder()
    }
    
    private func setupPasswordTextField() {
        passwordTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setPlaceholder(placeholder: "Password")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
