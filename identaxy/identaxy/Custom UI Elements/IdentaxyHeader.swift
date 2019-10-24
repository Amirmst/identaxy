//
//  IdentaxyHeader.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/15/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

// A view controller must inherit.
// Must be embedded in a navigation controller.
class IdentaxyHeader: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIConstants.IDENTAXY_PINK
        setBackButton()
    }
    
    func setBackButton() {
        // Set the pink '<' back button.
        self.navigationController?.navigationBar.topItem?.title = " "
    }
    
    // Sets header title. Not sure why Roboto font won't work...
    func setHeaderTitle(title: String) {
        self.title = title
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIConstants.ROBOTO_REGULAR]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
    }

}

