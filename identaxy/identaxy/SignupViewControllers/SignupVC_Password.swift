//
//  SignupVC_Password.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/22/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class SignupVC_Password: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: IdentaxyTextField!
    
    @IBOutlet weak var doneButton: RoundedCornerButton!
    
    @IBOutlet weak var createPassowrdLabel: UILabel!
    
    var doneButtonBottomAnchorConstraint: NSLayoutConstraint!
    var doneButtonInitialY: CGFloat!
    var doneButtonAboveKeyboardY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .dark
        passwordTextField.delegate = self
        setupPasswordTextField()
        placeDoneButton()
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
    
    @IBAction func onDone(_ sender: Any) {
        if let passwordTextField = passwordTextField.text {
            if (passwordTextField.count >= 6) {
                showSwipeVCWithLeftToRightTransition(swipeVCId: "Swipe-Screen")
                return
            }
        }
        let alertService = AlertService()
        print("ALERT!!!")
        let alertVC = alertService.alert(title: "Error", message: "Your password must be at least 6 characters.", button: "OK")
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - UI Methods
    
     func showSwipeVCWithLeftToRightTransition(swipeVCId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: swipeVCId) as! SwipingVC
        
        let rightToLeft = CATransition()
        rightToLeft.duration = 0.5
        rightToLeft.type = CATransitionType.push
        rightToLeft.subtype = CATransitionSubtype.fromRight
        rightToLeft.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(rightToLeft, forKey: kCATransition)
        
        controller.modalPresentationStyle = .overFullScreen
        self.present(controller, animated: false, completion: nil)
    }
    
    private func createPasswordLabelSetup() {
        createPassowrdLabel.text = "Create your Identaxy\npassword"
    }
    
    private func setupPasswordTextField() {
        passwordTextField.textContentType = .newPassword
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setPlaceholder(placeholder: "Password")
    }
    
    private func placeDoneButton() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButtonBottomAnchorConstraint = doneButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            doneButton.widthAnchor.constraint(lessThanOrEqualToConstant: 394),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            doneButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        doneButtonBottomAnchorConstraint.isActive = true
        doneButtonInitialY = doneButton.frame.origin.y
    }
    
    // MARK: moving buttons above keyboard
    @objc func keyboardWillchange(notification: NSNotification) {
        let doneButtonFrame = doneButton.frame
        print("keyboard will show \(notification.name.rawValue)")
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            doneButton.frame.origin.y = doneButtonFrame.origin.y
            return
        }
        if (notification.name == UIResponder.keyboardWillShowNotification
            || notification.name == UIResponder.keyboardWillChangeFrameNotification) {
            // move up
            if let doneButtonBottomAnchorConstraint = doneButtonBottomAnchorConstraint {
                if let doneButtonAboveKeyboardY = doneButtonAboveKeyboardY {
                    doneButton.frame.origin.y = doneButtonAboveKeyboardY
                }
                doneButtonBottomAnchorConstraint.isActive = false
            }
            doneButtonBottomAnchorConstraint = doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:
                -keyboardRect.height - 10)
            doneButtonBottomAnchorConstraint.isActive = true
            if (notification.name == UIResponder.keyboardWillShowNotification) {
                doneButtonAboveKeyboardY = doneButton.frame.origin.y
            }
        } else {
            if let doneButtonBottomAnchorConstraint = doneButtonBottomAnchorConstraint {
                doneButton.frame.origin.y = doneButtonInitialY
                doneButtonBottomAnchorConstraint.isActive = false
            }
            doneButtonBottomAnchorConstraint = doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            doneButtonBottomAnchorConstraint.isActive = true
        }
    }
}
