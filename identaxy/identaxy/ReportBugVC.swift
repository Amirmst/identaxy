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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeaderTitle(title: "Report a problem")
        overrideUserInterfaceStyle = .dark
        reportTextField.textColor = UIColor.lightGray
        reportTextField.placeholder = "Please provide a description of the problem..."
        // Do any additional setup after loading the view.
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
