//
//  AlertService.swift
//  identaxy
//
//  Created by Paul Purifoy on 10/14/19.
//  Copyright © 2019 amir. All rights reserved.
//
import UIKit

class AlertService {
    
        
    /*
    To use the custom alert, initialize an AlertService in your ViewController class
    and invoke the alert function with the title, message, and word you want to appear
    for the button. Usage example below.
     
     let alertService = AlertService()
     @IBAction func btnExample(_ sender: Any) {
     let alertVC = alertService.alert(title: "Error", message: "Do not create account yet.", button: "OK")
      present(alertVC, animated: true, completion: nil)
     }
     */
    
    func alert(title: String, message: String, button: String) -> IdentaxyAlertViewController {
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: "AlertVC") as! IdentaxyAlertViewController
        
        alertVC.popupTitle = title
        alertVC.popupMessage = message
        alertVC.buttonText = button
        
        return alertVC
    }
}
