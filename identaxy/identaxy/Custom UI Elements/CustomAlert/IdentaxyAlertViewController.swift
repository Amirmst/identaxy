//
//  IdentaxyAleryViewController.swift
//  identaxy
//
//  Created by Paul Purifoy on 10/14/19.
//  Copyright © 2019 amir. All rights reserved.
//
import UIKit

class IdentaxyAlertViewController: UIViewController {

    @IBOutlet weak var popup: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    
    var popupTitle: String!
    var popupMessage: String!
    var buttonText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        alertButton.setTitleColor(UIConstants.IDENTAXY_LIGHT_PINK, for: .normal)
        titleLabel.text = popupTitle
        messageLabel.text = popupMessage
        alertButton.setTitle(buttonText, for: .normal)
        popup.layer.cornerRadius = 10
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
