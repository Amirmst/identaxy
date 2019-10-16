//
//  IdentaxyHeader.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/15/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

// A view controller must inherit.
class IdentaxyHeader: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.barStyle = .black
        
        // Set the pink '<' back button.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIConstants.IDENTAXY_PINK

    }
    
    // Sets header title. Not sure why Roboto font won't work...
    func setHeaderTitle(title: String) {
        self.title = title
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white] //NSAttributedString.Key.font: UIConstants.ROBOTO_REGULAR]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
    }

}
