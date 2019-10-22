//
//  SignupVC-EmailAddress.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/22/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class SignupVC_EmailAddress: UIViewController {

    @IBOutlet weak var emailAddressTextField: IdentaxyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // hide the default NavBar border.
        overrideUserInterfaceStyle = .dark
        setupNavigationBar()
        setupEmailAddressTextField()
        emailAddressTextField.becomeFirstResponder()
    }
    
    private func setupNavigationBar() {
        // hide the default NavBar border.
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "chevron-left")?.withRenderingMode(.alwaysOriginal), for: .normal)
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setupEmailAddressTextField() {
        emailAddressTextField.textContentType = .emailAddress
        emailAddressTextField.setPlaceholder(placeholder: "Email address")
    }
    
    private func placeUIComponents() {

    }
    
    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
