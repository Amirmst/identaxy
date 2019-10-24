//
//  UpdateEmailVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/23/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class UpdateEmailVC: IdentaxyHeader {
    
    let alertService = AlertService()
    var delegate: UIViewController!
    var updateButtonBottomAnchorConstraint: NSLayoutConstraint!
    var updateButtonInitialY: CGFloat!
    
    @IBOutlet weak var emailTextField: IdentaxyTextField!
    @IBOutlet weak var updateButton: PillShapedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.setHeaderTitle(title: "Update Email Address")
        emailTextField.setPlaceholder(placeholder: "foo@bar.com")
        emailTextField.textColor = UIColor.gray
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        // Setup 'Current' label.
        var pos = (screenWidth / 2) - (screenWidth / 4) + 30
        let current = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        current.center = CGPoint(x: pos, y: 120)
        current.textAlignment = .left
        current.text = "Current"
        self.view.addSubview(current)
                
        // Setup 'curEmail' label.
        pos = screenWidth - (screenWidth / 4) - 30
        let curEmail = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        curEmail.center = CGPoint(x: pos, y: 120)
        curEmail.textAlignment = .right
        curEmail.text = "foo@bar.com"
        self.view.addSubview(curEmail)
        
        // Add the text field.
        let emailField = IdentaxyTextField()
        emailField.setup()
        let emailView = UIView()
        emailView.addSubview(emailField)
        emailField.center = emailView.center
        self.view.addSubview(emailView)
        
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        // Constraints.
//        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        activateintialConstraints()
        
        buttonView.addSubview(updateButton)
        
        updateButton.centerXAnchor.constraint(equalTo:buttonView.centerXAnchor).isActive = true
        updateButton.widthAnchor.constraint(equalToConstant: 300).isActive = true

        view.addSubview(buttonView)

        buttonView.heightAnchor.constraint(equalToConstant:40).isActive = true
        buttonView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        buttonView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    func activateintialConstraints() {
            // setting constraints manually in code. Deacrtivate storyboard stuff.
            updateButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                // MARK: - Login button constraints
                updateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                updateButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
                updateButton.widthAnchor.constraint(lessThanOrEqualToConstant: 394),
                updateButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
                updateButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
                // MARK: - Forgot password button constraints
                updateButton.heightAnchor.constraint(equalToConstant: 40)
            ])
            updateButtonInitialY = updateButton.frame.origin.y
    //        logoutButtonBottomAnchorConstraint.isActive = true
        }
    

    @IBAction func updateButtonPressed(_ sender: Any) {
        if (emailTextField.text!.isEmpty) {
            let alertVC = alertService.alert(title: "Error", message: "Nothing has been entered", button: "Dismiss")
            present(alertVC, animated: true, completion: nil)
        } else {
            let alertVC = alertService.alert(title: "Success!", message: "Please check & verify your email", button: "OK")
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    // code to dismiss keyboard when user clicks on background

    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
