//
//  ForgotPasswordVC.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/22/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordVC: IdentaxyHeader, UITextFieldDelegate {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    let alertService = AlertService()
    @IBOutlet weak var emailTextField: IdentaxyTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setColorMode()
        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        setupNavigationBar()
        writeLabels()
        emailTextField.setPlaceholder(placeholder: "Email address")
        emailTextField.keyboardType = .emailAddress
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailTextField.becomeFirstResponder()
    }
    
    private func setupNavigationBar() {
        let resetButton = UIButton(type: .system)
        resetButton.titleLabel?.font = UIConstants.AVENIR_NEXT_REGULAR_15
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(onResetPressed(sender:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: resetButton)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIConstants.AVENIR_NEXT_REGULAR_20!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Password Reset"
    }
    
    private func writeLabels() {
        topLabel.font = UIConstants.AVENIR_NEXT_REGULAR_15
        bottomLabel.font = UIConstants.AVENIR_NEXT_REGULAR_15
        topLabel.text = "Please enter the email address associated\n"
            + "with your account."
        bottomLabel.text = "We’ll send you an email with password\n"
            + "reset instructions."
    }

    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onResetPressed(sender: UIButton) {
        resetPassowrd()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resetPassowrd()
        return false
    }
    
    func resetPassowrd() {
        print("RESET PRESSED")
        if let emailText = emailTextField.text {
            if (emailText.count > 0) {
                let alertVC = alertService.alert(title: "Please check your email!",
                                                 message: "We sent you an email with password reset\ninstructions.", button: "OK")
                present(alertVC, animated: true, completion: nil)
                Auth.auth().sendPasswordReset(withEmail: emailText) { error in
                  if let error = error {
                    let alertVC = self.alertService.alert(title: "Error", message: error.localizedDescription, button: "Dismiss")
                    self.present(alertVC, animated: true, completion: nil)
                  } else {
                    let alertVC = self.alertService.alert(title: "Please check your email!", message: "We sent you an email with password reset instruction", button: "OK")
                    self.present(alertVC, animated: true, completion: nil)
                  }
                }
                return
            }
        }
        let alertVC = alertService.alert(title: "Error",
                                         message: "Please provide a valid email address.", button: "OK")
        present(alertVC, animated: true, completion: nil)
    }
}
