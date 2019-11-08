//
//  LoadingVC.swift
//  identaxy
//
//  Created by Cepak, Alexandria N on 11/7/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailAddressTextField: IdentaxyTextField!
    
    @IBOutlet weak var continueButton: RoundedCornerButton!
    
    let passwordScreenSegue: String = "passwordScreenSegue"

    var continueButtonBottomAnchorConstraint: NSLayoutConstraint!
    var continueButtonInitialY: CGFloat!
    var continueButtonAboveKeyboardY: CGFloat!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // hide the default NavBar border.
        overrideUserInterfaceStyle = .dark
        emailAddressTextField.delegate = self
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        setupNavigationBar()
        setupEmailAddressTextField()
        placeContinueButton()
        emailAddressTextField.becomeFirstResponder()
    }
    
    deinit {
         // Stop listening for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - Logic
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == passwordScreenSegue) {
            if (emailAddressTextField.text != nil && emailAddressTextField.text != "") {
                return true
            }
        }
        
        let alertService = AlertService()
        print("ALERT!!!")
        let alertVC = alertService.alert(title: "Error", message: "Please enter a valid email address.", button: "OK")
        present(alertVC, animated: true, completion: nil)
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == passwordScreenSegue) {
            let dest = segue.destination as! SignupVC_Password
            dest.signupEmail = emailAddressTextField.text
        }
    }
    
    // MARK: - UI Methods
    
    private func setupNavigationBar() {
        // hide the default NavBar border.
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "chevron-left")?.withRenderingMode(.alwaysOriginal), for: .normal)
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupEmailAddressTextField() {
        emailAddressTextField.textContentType = .username // to disable type assist
        emailAddressTextField.setPlaceholder(placeholder: "Email address")
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
    
    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: moving buttons above keyboard
    @objc func keyboardWillchange(notification: NSNotification) {
        let currentButtonFrame = continueButton.frame
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            continueButton.frame.origin.y = currentButtonFrame.origin.y
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
