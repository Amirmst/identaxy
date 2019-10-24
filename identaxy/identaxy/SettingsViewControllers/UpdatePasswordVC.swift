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
    var updateButtonBottomAnchorConstraint: NSLayoutConstraint!
    var updateButtonInitialY: CGFloat!

    @IBOutlet weak var currentPassTextField: IdentaxyTextField!
    @IBOutlet weak var newPassTextField: IdentaxyTextField!
    @IBOutlet weak var confirmPassTextField: IdentaxyTextField!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var updateButton: PillShapedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.setHeaderTitle(title: "Update Password")
        forgotPassButton.setTitleColor(UIConstants.IDENTAXY_PINK, for: .normal)
        currentPassTextField.setPlaceholder(placeholder: "Current password")
        currentPassTextField.textColor = UIColor.gray
        
        newPassTextField.setPlaceholder(placeholder: "New password")
        newPassTextField.textColor = UIColor.gray
        
        confirmPassTextField.setPlaceholder(placeholder: "Confirm password")
        confirmPassTextField.textColor = UIColor.gray
        
        
        

        // Do any additional setup after loading the view.
        
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        // Constraints.
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
