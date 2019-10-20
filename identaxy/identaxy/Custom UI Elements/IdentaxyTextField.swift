//
//  IdentaxyTextField.swift
//  identaxy
//
//  Created by Paul Purifoy on 10/14/19.
//  Copyright © 2019 amir. All rights reserved.
//
import UIKit

class IdentaxyTextField: UITextField {
    
    // Setup the custom textfield elements.
    func setup() {
        self.borderStyle = .none
        self.font = UIConstants.ROBOTO_BOLD
        self.tintColor = UIConstants.IDENTAXY_PINK
        self.text = ""
        self.placeholder = ""
        self.textAlignment = .center
    }
    
    // Use this function to change the placeholder text from screen to screen.
    func setPlaceholder(placeholder: String) {
        let attributes = [NSAttributedString.Key.font: UIConstants.ROBOTO_REGULAR]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes as [NSAttributedString.Key : Any])
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
