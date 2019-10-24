//
//  UpdateEmailVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/23/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class UpdateEmailVC: IdentaxyHeader {
    
    var delegate: UIViewController!
    
    let alertService = AlertService()

    @IBOutlet weak var emailTextField: IdentaxyTextField!
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
