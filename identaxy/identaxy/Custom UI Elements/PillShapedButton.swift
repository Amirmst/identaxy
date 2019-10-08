//
//  PillShapedButton.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/7/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

// Costum pill shaped button.
class PillShapedButton: RoundedCornerButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // override the radius. Make it pill shaped.
        layer.cornerRadius = 20
    }
}
