//
//  SignupVC_Name.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/23/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignupVC_Name: IdentaxyHeader, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: IdentaxyTextField!
    @IBOutlet weak var lastNameTextField: IdentaxyTextField!
    
    @IBOutlet weak var doneButton: RoundedCornerButton!
    
    var doneButtonBottomAnchorConstraint: NSLayoutConstraint!
    var doneButtonInitialY: CGFloat!
    var doneButtonAboveKeyboardY: CGFloat!
    
    var signupEmail: String!
    var signupPassword: String!
    var database: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setColorMode()
        // Do any additional setup after loading the view.
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        database = Database.database().reference()

        setupTextFields()
        placeDoneButton()
        
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillchange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        firstNameTextField.becomeFirstResponder()
    }
    
    deinit {
         // Stop listening for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - Logic
    
    @IBAction func onDone(_ sender: Any) {
        let alertService = AlertService()
        if (firstNameTextField.text != nil && firstNameTextField.text != ""
                && lastNameTextField.text != nil && lastNameTextField.text != "") {
            Auth.auth().createUser(withEmail: signupEmail, password: signupPassword) { authResult, error in
                if(error == nil) {
                    // Gets the user's unique id
                    let uid = Auth.auth().currentUser?.uid
                    let firstName = "\(self.firstNameTextField.text!)"
                    let lastName = "\(self.lastNameTextField.text!)"
                    
                    // Creates the json for sending to our database. Can modify to add objects without changing a schema.
                    let json = ["first_name": firstName,
                                "last_name": lastName]
                                as [String : Any]
                    
                    self.database.child("users").child(uid!).setValue(json)
                    
                    UserDefaults.standard.set(firstName, forKey: "firstName")
                    UserDefaults.standard.set(lastName, forKey: "lastName")
                    
                    self.showSwipeVCWithLeftToRightTransition(swipeVCId: "Swipe-Screen")
                } else {
                    let alertVC = alertService.alert(title: "Error", message: "There was an error signing up.", button: "OK")
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
            return
        }
        print("ALERT!!!")
        let alertVC = alertService.alert(title: "Error", message: "Please enter your name and last name.", button: "OK")
        present(alertVC, animated: true, completion: nil)
    }
    
    func showSwipeVCWithLeftToRightTransition(swipeVCId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: swipeVCId) as! SwipingNewVC
        
        let rightToLeft = CATransition()
        rightToLeft.duration = 0.5
        rightToLeft.type = CATransitionType.push
        rightToLeft.subtype = CATransitionSubtype.fromRight
        rightToLeft.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(rightToLeft, forKey: kCATransition)
        
        controller.modalPresentationStyle = .overFullScreen
        self.present(controller, animated: false, completion: nil)
    }
    
    // MARK: - UI Methods
    
    private func setupTextFields() {
        firstNameTextField.textContentType = .username // to disable type assist
        firstNameTextField.setPlaceholder(placeholder: "First Name")
        lastNameTextField.textContentType = .username // to disable type assist
        lastNameTextField.setPlaceholder(placeholder: "Last Name")
    }
    
    private func placeDoneButton() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButtonBottomAnchorConstraint = doneButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            doneButton.widthAnchor.constraint(lessThanOrEqualToConstant: 394),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            doneButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        doneButtonBottomAnchorConstraint.isActive = true
        doneButtonInitialY = doneButton.frame.origin.y
    }
    
    // MARK: moving buttons above keyboard
    @objc func keyboardWillchange(notification: NSNotification) {
        let doneButtonFrame = doneButton.frame
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            doneButton.frame.origin.y = doneButtonFrame.origin.y
            return
        }
        if (notification.name == UIResponder.keyboardWillShowNotification
            || notification.name == UIResponder.keyboardWillChangeFrameNotification) {
            // move up
            if let doneButtonBottomAnchorConstraint = doneButtonBottomAnchorConstraint {
                if let doneButtonAboveKeyboardY = doneButtonAboveKeyboardY {
                    doneButton.frame.origin.y = doneButtonAboveKeyboardY
                }
                doneButtonBottomAnchorConstraint.isActive = false
            }
            doneButtonBottomAnchorConstraint = doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:
                -keyboardRect.height - 10)
            doneButtonBottomAnchorConstraint.isActive = true
            if (notification.name == UIResponder.keyboardWillShowNotification) {
                doneButtonAboveKeyboardY = doneButton.frame.origin.y
            }
        } else {
            if let doneButtonBottomAnchorConstraint = doneButtonBottomAnchorConstraint {
                doneButton.frame.origin.y = doneButtonInitialY
                doneButtonBottomAnchorConstraint.isActive = false
            }
            doneButtonBottomAnchorConstraint = doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
            doneButtonBottomAnchorConstraint.isActive = true
        }
    }

}
