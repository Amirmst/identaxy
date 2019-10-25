//
//  ReportBugVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class ReportBugVC: IdentaxyHeader {
    
    var delegate: UIViewController!
    let alertService = AlertService()
        
    @IBOutlet weak var reportTextField: IdentaxyTextField!
    @IBOutlet weak var submitButton: PillShapedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeaderTitle(title: "Report a problem")
        self.navigationController?.navigationBar.topItem?.title = "Help & Support"
        overrideUserInterfaceStyle = .dark
        reportTextField.setPlaceholder(placeholder: "Please provide a description of the problem...")
        
        activateintialConstraints()
    }
    
    func activateintialConstraints() {
            // setting constraints manually in code. Deacrtivate storyboard stuff.
            submitButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                // MARK: - Login button constraints
                submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                submitButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
                submitButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
                submitButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
                submitButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if(reportTextField.text!.isEmpty) {
            let alertVC = alertService.alert(title: "Error", message: "Please enter a description of the problem", button: "OK")
            present(alertVC, animated: true, completion: nil)
        } else {
            let alertVC = alertService.alert(title: "Thanks for your feedback!", message: "We will look into this problem 🔎", button: "OK")
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    // Quick fix. to change later!
    // code to dismiss keyboard when user clicks on background

    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
