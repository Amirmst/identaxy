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
          // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true)
    }
    
}
