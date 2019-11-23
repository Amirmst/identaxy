//
//  UpdateEmailVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/23/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UpdateEmailVC: IdentaxyHeader, UITextFieldDelegate {
    
    let alertService = AlertService()
    var delegate: UIViewController!
    
    @IBOutlet weak var emailTextField: IdentaxyTextField!
    @IBOutlet weak var updateButton: PillShapedButton!
    @IBOutlet weak var curEmailLabel: UILabel!
    
    var updateButtonBottomAnchorConstraint: NSLayoutConstraint!
    var updateButtonInitialY: CGFloat!
    var updateButtonAboveKeyboardY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // additional set ups
        emailTextField.delegate = self
        self.setHeaderTitle(title: "Update Email Address")
        self.setColorMode()
        emailTextField.setPlaceholder(placeholder: "Enter a new email address to update")
        activateintialConstraints()
        
        emailTextField.textContentType = .oneTimeCode
        emailTextField.autocorrectionType = .no
        
        self.curEmailLabel.text = Auth.auth().currentUser?.email!
        
        // listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        emailTextField.becomeFirstResponder()
    }
    
    override func setColorMode() {
        super.setColorMode()
        super.adjustButtonColor(button: updateButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        curEmailLabel.text = Auth.auth().currentUser?.email!
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
        
        updateButtonBottomAnchorConstraint = updateButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        
        NSLayoutConstraint.activate([
            // MARK: - Login button constraints
            updateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            updateButton.widthAnchor.constraint(lessThanOrEqualToConstant: 394),
            updateButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            updateButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            updateButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        updateButtonBottomAnchorConstraint.isActive = true
        updateButtonInitialY = updateButton.frame.origin.y
    }
    
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        if (emailTextField.text!.isEmpty) {
            let alertVC = alertService.alert(title: "Error", message: "Please enter a valid email address.", button: "OK")
            present(alertVC, animated: true, completion: nil)
        } else {
            let newEmail = emailTextField.text
            Auth.auth().currentUser?.updateEmail(to: newEmail!) { (error) in
              if let error = error {
                let alertVC = self.alertService.alert(title: "Error", message: error.localizedDescription, button: "OK")
                self.present(alertVC, animated: true, completion: nil)
              } else {
                let alertVC = self.alertService.alert(title: "Email Adress Updated", message: "You have succesfully updated your email address.", button: "OK")
                self.present(alertVC, animated: true, completion: nil)
                self.curEmailLabel.text = Auth.auth().currentUser?.email!
              }
            }
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
                -keyboardRect.height - 20)
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
