//
//  ReportBugVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import MessageUI

class ReportBugVC: IdentaxyHeader, MFMailComposeViewControllerDelegate {
    
    var delegate: UIViewController!
    let alertService = AlertService()
        
    @IBOutlet weak var submitButton: PillShapedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Help & Support"
        overrideUserInterfaceStyle = .dark
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["identaxy@gmail.com"])
            mail.setSubject("Bug Report")
            mail.setMessageBody("<p>Please provide a description of the problem...</p>", isHTML: true)
            present(mail, animated: true)
            } else {
                let alertService = AlertService()
                let alertVC = alertService.alert(title: "Mail settings not configured", message: "Please send an email dricetly to identaxy@gmail.com with \"Bug Report\" as the subject", button: "OK")
                present(alertVC, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true)
    }
}
