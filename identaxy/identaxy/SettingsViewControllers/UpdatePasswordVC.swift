//
//  UpdatePasswordVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

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
        let alertVC = alertService.alert(title: "Please check your email!", message: "We sent you an email with password reset instruction", button: "OK")
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        if(!currentPassTextField.text!.isEmpty && !newPassTextField.text!.isEmpty && !confirmPassTextField.text!.isEmpty) {
            if(newPassTextField.text != confirmPassTextField.text) {
                let alertVC = alertService.alert(title: "Error", message: "Passwords do not match", button: "Dismiss")
                present(alertVC, animated: true, completion: nil)
            } else {
                let alertVC = alertService.alert(title: "Success!", message: "You have successfully changed your password", button: "OK")
                present(alertVC, animated: true, completion: nil)
            }
        } else {
            let alertVC = alertService.alert(title: "Error", message: "Please enter all fields", button: "Dismiss")
            present(alertVC, animated: true, completion: nil)
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
