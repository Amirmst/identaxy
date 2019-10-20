//
//  SignInVC.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/7/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class SignInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RoundedCornerButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var buttonConstraint: NSLayoutConstraint!
    var initialY: CGFloat!
    var aboveKeyboardY: CGFloat!
        
    override func loadView() {
        super.loadView()
        overrideUserInterfaceStyle = .dark
        activateintialConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // automatically select email address field.
        emailAddressTextField.becomeFirstResponder()
    }
    
    deinit {
         // Stop listening for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillchange(notification: NSNotification) {
        let currentButtonFrame = loginButton.frame
        print("keyboard will show \(notification.name.rawValue)")
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            loginButton.frame.origin.y = currentButtonFrame.origin.y
            return
        }
        if (notification.name == UIResponder.keyboardWillShowNotification
            || notification.name == UIResponder.keyboardWillChangeFrameNotification) {
            // move up
            if let buttonConstraint = buttonConstraint {
                if let aboveKeyboardY = aboveKeyboardY {
                    loginButton.frame.origin.y = aboveKeyboardY
                }
                buttonConstraint.isActive = false
            }
            buttonConstraint = loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:
                -keyboardRect.height - 50)
            buttonConstraint.isActive = true
            if (notification.name == UIResponder.keyboardWillShowNotification) {
                 aboveKeyboardY = loginButton.frame.origin.y
            }
        } else {
            if let buttonConstraint = buttonConstraint {
                loginButton.frame.origin.y = initialY
                buttonConstraint.isActive = false
            }
            buttonConstraint = loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            buttonConstraint.isActive = true
        }
    }
    
    func activateintialConstraints() {
        // setting constraints manually in code. Deacrtivate storyboard stuff.
        logo.translatesAutoresizingMaskIntoConstraints = false
        emailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonConstraint = loginButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        NSLayoutConstraint.activate([
            // MARK: - Logo constraints
            logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 90),
            logo.widthAnchor.constraint(equalToConstant: 115),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor, multiplier: 66/115),
            
            // MARK: - Email textfield constraints
            emailAddressTextField.topAnchor.constraint(greaterThanOrEqualTo: logo.bottomAnchor, constant: 40),
            emailAddressTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -45),
            emailAddressTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 45),
            
            // MARK: - Password textfield constraints
            passwordTextField.topAnchor.constraint(lessThanOrEqualTo: emailAddressTextField.bottomAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -45),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 45),
            
            // MARK: - Login button constraints
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.widthAnchor.constraint(lessThanOrEqualToConstant: 394),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            loginButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            
            // MARK: - Forgot password button constraints
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            forgotPasswordButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        buttonConstraint.isActive = true
        initialY = loginButton.frame.origin.y
    }
}
