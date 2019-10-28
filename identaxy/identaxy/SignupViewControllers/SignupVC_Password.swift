//
//  SignupVC_Password.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/22/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class SignupVC_Password: UIViewController, UITextFieldDelegate {

    let nameScreenSegue: String = "nameScreenSegue"
    
    @IBOutlet weak var passwordTextField: IdentaxyTextField!
    
    @IBOutlet weak var continueButton: RoundedCornerButton!
    
    @IBOutlet weak var createPassowrdLabel: UILabel!
    
    var continueButtonBottomAnchorConstraint: NSLayoutConstraint!
    var continueButtonInitialY: CGFloat!
    var continueButtonAboveKeyboardY: CGFloat!
    
    var signupEmail: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .dark
        passwordTextField.delegate = self
        setupPasswordTextField()
        placeContinueButton()
        createPasswordLabelSetup()
        
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        passwordTextField.becomeFirstResponder()
    }
    
    deinit {
         // Stop listening for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - Logic
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == nameScreenSegue) {
            if (passwordTextField.text != nil && passwordTextField.text!.count >= 6) {
                return true
            }
        }
        
        let alertService = AlertService()
        print("ALERT!!!")
        let alertVC = alertService.alert(title: "Error", message: "Your password must be at least 6 characters.", button: "OK")
        present(alertVC, animated: true, completion: nil)
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == nameScreenSegue) {
            let dest = segue.destination as! SignupVC_Name
            dest.signupEmail = signupEmail
            dest.signupPassword = passwordTextField.text
        }
    }
    
    // MARK: - UI Methods
    
    private func createPasswordLabelSetup() {
        createPassowrdLabel.text = "Create your Identaxy\npassword"
    }
    
    private func setupPasswordTextField() {
        passwordTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setPlaceholder(placeholder: "Password")
    }
    
    private func placeContinueButton() {
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButtonBottomAnchorConstraint = continueButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        NSLayoutConstraint.activate([
            continueButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            continueButton.widthAnchor.constraint(lessThanOrEqualToConstant: 394),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            continueButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        continueButtonBottomAnchorConstraint.isActive = true
        continueButtonInitialY = continueButton.frame.origin.y
    }
    
    // MARK: moving buttons above keyboard
    @objc func keyboardWillchange(notification: NSNotification) {
        let continueButtonFrame = continueButton.frame
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            continueButton.frame.origin.y = continueButtonFrame.origin.y
            return
        }
        if (notification.name == UIResponder.keyboardWillShowNotification
            || notification.name == UIResponder.keyboardWillChangeFrameNotification) {
            // move up
            if let continueButtonBottomAnchorConstraint = continueButtonBottomAnchorConstraint {
                if let continueButtonAboveKeyboardY = continueButtonAboveKeyboardY {
                    continueButton.frame.origin.y = continueButtonAboveKeyboardY
                }
                continueButtonBottomAnchorConstraint.isActive = false
            }
            continueButtonBottomAnchorConstraint = continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:
                -keyboardRect.height - 10)
            continueButtonBottomAnchorConstraint.isActive = true
            if (notification.name == UIResponder.keyboardWillShowNotification) {
                continueButtonAboveKeyboardY = continueButton.frame.origin.y
            }
        } else {
            if let continueButtonBottomAnchorConstraint = continueButtonBottomAnchorConstraint {
                continueButton.frame.origin.y = continueButtonInitialY
                continueButtonBottomAnchorConstraint.isActive = false
            }
            continueButtonBottomAnchorConstraint = continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            continueButtonBottomAnchorConstraint.isActive = true
        }
    }
}
