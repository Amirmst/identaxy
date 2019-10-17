//
//  SignInVC.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/7/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RoundedCornerButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        // Do any additional setup after loading the view.
        // automatically select email address field.
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillShow),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil
//        )
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillHide),
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil
//        )
        emailAddressTextField.becomeFirstResponder()
    }
    
//    @objc func keyboardWillShow(_ notification: NSNotification) {
//
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//
//            self.loginButton.frame.origin.y -= keyboardHeight
//            self.forgotPasswordButton.frame.origin.y -= keyboardHeight
//        }
//    }
    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//
//            self.loginButton.frame.origin.y += keyboardHeight
//            self.forgotPasswordButton.frame.origin.y += keyboardHeight
//        }
//    }
    
}
