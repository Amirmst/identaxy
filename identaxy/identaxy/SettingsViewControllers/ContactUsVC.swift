//
//  ContactUsVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsVC: IdentaxyHeader, MFMailComposeViewControllerDelegate {
    
    var delegate: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeaderTitle(title: "Contact Us")
        overrideUserInterfaceStyle = .dark
    }
    
    @IBAction func emailClicked(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
          let mail = MFMailComposeViewController()
          mail.mailComposeDelegate = self
          mail.setToRecipients(["identaxy@gmail.com"])
          present(mail, animated: true)
        } else {
            let alertService = AlertService()
            let alertVC = alertService.alert(title: "Mail settings not configured", message: "Please send an email dricetly to identaxy@gmail.com", button: "OK")
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true)
    }
    
}
