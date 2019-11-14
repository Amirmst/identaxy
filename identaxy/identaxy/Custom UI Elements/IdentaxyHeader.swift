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
    
    var darkModeOn:Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        // Set the default.
        let darkModeOn = UserDefaults.standard.bool(forKey:"darkModeOn")
        if(darkModeOn) {
            UserDefaults.standard.set(true, forKey:"darkModeOn")
            print("set initial dark mode")
        }
        setColorMode()
    }
    
    func setColorMode() {
        let darkModeOn = UserDefaults.standard.bool(forKey:"darkModeOn")
        if(darkModeOn) {
            overrideUserInterfaceStyle = .dark
            navigationController?.navigationBar.barTintColor = UIColor.systemGray6
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        } else {
            overrideUserInterfaceStyle = .light
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        setBackButton()
    }
    
    func setBackButton() {
        // Set the pink '<' back button.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    // Sets header title. Not sure why Roboto font won't work...
    func setHeaderTitle(title: String) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIConstants.AVENIR_NEXT_REGULAR_20!]
        navigationItem.title = title
    }

}

