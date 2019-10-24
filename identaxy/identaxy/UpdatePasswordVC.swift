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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotPassButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        
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
