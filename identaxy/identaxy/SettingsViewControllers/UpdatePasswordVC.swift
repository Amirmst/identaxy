//
//  UpdatePasswordVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UpdatePasswordVC: IdentaxyHeader {
    
    let alertService = AlertService()
    
    var delegate: UIViewController!
    
    @IBOutlet weak var currentPassTextField: IdentaxyTextField!
    @IBOutlet weak var newPassTextField: IdentaxyTextField!
    @IBOutlet weak var confirmPassTextField: IdentaxyTextField!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var updateButton: PillShapedButton!
    
    var updateButtonBottomAnchorConstraint: NSLayoutConstraint!
    var updateButtonInitialY: CGFloat!
    var updateButtonAboveKeyboardY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.setHeaderTitle(title: "Update Password")
        forgotPassButton.setTitleColor(UIConstants.IDENTAXY_PINK, for: .normal)
        currentPassTextField.setPlaceholder(placeholder: "Enter your current password")
        newPassTextField.setPlaceholder(placeholder: "Enter your new password")
        confirmPassTextField.setPlaceholder(placeholder: "Confirm password")
        
        currentPassTextField.textContentType = .oneTimeCode
        newPassTextField.textContentType = .oneTimeCode
        confirmPassTextField.textContentType = .oneTimeCode
        
        currentPassTextField.autocorrectionType = .no
        newPassTextField.autocorrectionType = .no
        confirmPassTextField.autocorrectionType = .no
        
        activateintialConstraints()
        
        // listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        // Stop listening for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func activateintialConstraints() {
        // setting constraints manually in code. Deacrtivate storyboard stuff.
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPassButton.translatesAutoresizingMaskIntoConstraints = false
        
         updateButtonBottomAnchorConstraint = updateButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        
        NSLayoutConstraint.activate([
            // MARK: - Login button constraints
            updateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            updateButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            updateButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            updateButton.heightAnchor.constraint(equalToConstant: 40),
            
            forgotPassButton.topAnchor.constraint(equalTo: currentPassTextField.bottomAnchor, constant: 12),
            forgotPassButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        updateButtonBottomAnchorConstraint.isActive = true
        updateButtonInitialY = updateButton.frame.origin.y
    }
    
    
    @IBAction func forgotPassButtonPressed(_ sender: Any) {
        // Forgot password.
        let curEmail = Auth.auth().currentUser?.email
        Auth.auth().sendPasswordReset(withEmail: curEmail!) { error in
          if let error = error {
            print("Could not send password reset: \(error.localizedDescription)")
          } else {
            let alertVC = self.alertService.alert(title: "Please check your email!", message: "We sent you an email with password reset instruction", button: "OK")
            self.present(alertVC, animated: true, completion: nil)
          }
        }
    }
    
    func updatePasswordAlert(alertMsg: String, error: Bool) {
        let alertTitle = error ? "Error" : "Success"
        let alertButton = error ? "Dismiss" : "OK"
        let alertVC = alertService.alert(title: alertTitle, message: alertMsg, button: alertButton)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        
        let curPassword = currentPassTextField.text!
        let newPassword = newPassTextField.text!
        let confirmPassword = confirmPassTextField.text!
        
        if(!curPassword.isEmpty && !newPassword.isEmpty && !confirmPassword.isEmpty) {
            if(newPassword != confirmPassword) {
                updatePasswordAlert(alertMsg: "New password and confirm password do not match.", error: true)
            } else {

                let user = Auth.auth().currentUser
                let curEmail = user?.email!
                let credential = EmailAuthProvider.credential(withEmail: curEmail!, password: curPassword)

                user?.reauthenticate(with: credential) { user, error in
                  if let error = error {
                    self.updatePasswordAlert(alertMsg: "Current password is incorrect.", error: true)
                  } else {
                    // User re-authenticated.
                    Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
                      if let error = error {
                        self.updatePasswordAlert(alertMsg: error.localizedDescription, error: true)
                      } else {
                        self.updatePasswordAlert(alertMsg: "You have successfully changed your password.", error: false)
                      }
                    }
                  }
                }
            }
        } else {
            self.updatePasswordAlert(alertMsg: "Please enter all fields", error: true)
        }

    }
    
    // MARK: moving buttons above keyboard
    @objc func keyboardWillchange(notification: NSNotification) {
        let updateButtonFrame = updateButton.frame
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            updateButton.frame.origin.y = updateButtonFrame.origin.y
            return
        }
        if (notification.name == UIResponder.keyboardWillShowNotification
            || notification.name == UIResponder.keyboardWillChangeFrameNotification) {
            // move up
            if let updateButtonBottomAnchorConstraint = updateButtonBottomAnchorConstraint {
                if let updateButtonAboveKeyboardY = updateButtonAboveKeyboardY {
                    updateButton.frame.origin.y = updateButtonAboveKeyboardY
                }
                updateButtonBottomAnchorConstraint.isActive = false
            }
            updateButtonBottomAnchorConstraint = updateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:
                -keyboardRect.height - 10)
            updateButtonBottomAnchorConstraint.isActive = true
            if (notification.name == UIResponder.keyboardWillShowNotification) {
                updateButtonAboveKeyboardY = updateButton.frame.origin.y
            }
        } else {
            if let updateButtonBottomAnchorConstraint = updateButtonBottomAnchorConstraint {
                updateButton.frame.origin.y = updateButtonInitialY
                updateButtonBottomAnchorConstraint.isActive = false
            }
            updateButtonBottomAnchorConstraint = updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            updateButtonBottomAnchorConstraint.isActive = true
        }
    }
    
}
