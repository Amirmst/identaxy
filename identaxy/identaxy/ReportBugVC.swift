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
    
    var submitButtonBottomAnchorConstraint: NSLayoutConstraint!
    var submitButtonInitialY: CGFloat!
    
    @IBOutlet weak var reportTextField: IdentaxyTextField!
    @IBOutlet weak var submitButton: PillShapedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeaderTitle(title: "Report a problem")
        self.navigationController?.navigationBar.topItem?.title = "Help & Support"
        overrideUserInterfaceStyle = .dark
        reportTextField.textColor = UIColor.lightGray
        reportTextField.placeholder = "Please provide a description of the problem..."
        
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        activateintialConstraints()
        
        buttonView.addSubview(submitButton)
        
        submitButton.centerXAnchor.constraint(equalTo:buttonView.centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 300).isActive = true

        view.addSubview(buttonView)

        buttonView.heightAnchor.constraint(equalToConstant:40).isActive = true
        buttonView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        buttonView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
    }
    
    func activateintialConstraints() {
            // setting constraints manually in code. Deacrtivate storyboard stuff.
            submitButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                // MARK: - Login button constraints
                submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                submitButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
                submitButton.widthAnchor.constraint(lessThanOrEqualToConstant: 394),
                submitButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
                submitButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
                // MARK: - Forgot password button constraints
                submitButton.heightAnchor.constraint(equalToConstant: 40)
            ])
            submitButtonInitialY = submitButton.frame.origin.y
    //        logoutButtonBottomAnchorConstraint.isActive = true
        }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if(reportTextField.text!.isEmpty) {
            let alertVC = alertService.alert(title: "Error", message: "Nothing has been entered", button: "Dismiss")
            present(alertVC, animated: true, completion: nil)
        } else {
            let alertVC = alertService.alert(title: "Thanks for the feedback!", message: "You have successfully submitted your problem", button: "OK")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
