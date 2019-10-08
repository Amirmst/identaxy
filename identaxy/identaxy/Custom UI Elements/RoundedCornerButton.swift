//
//  RoundedCornerButton.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/7/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

// extension to set bg color given a state
// taken from: https://stackoverflow.com/a/30604658
extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

// Costum rounded corner button.
class RoundedCornerButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // set bg color for different states
        setBackgroundColor(color: UIConstants.IDENTAXY_PINK, forState: .normal)
        setBackgroundColor(color: UIConstants.IDENTAXY_LIGHT_PINK, forState: .selected)
        setBackgroundColor(color: UIConstants.IDENTAXY_LIGHT_PINK, forState: .highlighted)
        
        // set corner radius
        layer.cornerRadius = 6.0
        
        // set title font and color
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.font = UIConstants.ROBOTO_REGULAR
    }
    
}
