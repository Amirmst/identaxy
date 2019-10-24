//
//  UpdatePasswordVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class UpdatePasswordVC: IdentaxyHeader {
    
    var delegate: UIViewController!
    
    let alertService = AlertService()

    @IBOutlet weak var currentPassTextField: IdentaxyTextField!
    @IBOutlet weak var newPassTextField: IdentaxyTextField!
    @IBOutlet weak var confirmPassTextField: IdentaxyTextField!
    @IBOutlet weak var forgotPassButton: UIButton!
    
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
