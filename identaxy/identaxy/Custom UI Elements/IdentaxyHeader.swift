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
        self.navigationController?.navigationBar.tintColor = UIConstants.IDENTAXY_PINK
        setBackButton()
    }
    
    func setBackButton() {
        // Set the pink '<' back button.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    // Sets header title. Not sure why Roboto font won't work...
    func setHeaderTitle(title: String) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIConstants.AVENIR_NEXT_REGULAR_20!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = title
    }

}

