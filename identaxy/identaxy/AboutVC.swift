//
//  AboutVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class AboutVC: IdentaxyHeader {
    
    var delegate: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.setHeaderTitle(title: "About")

        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        // Setup 'versionLabel' label.
        var pos = (screenWidth / 2) - (screenWidth / 4) + 30
        let versionLabel = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        versionLabel.center = CGPoint(x: pos, y: 120)
        versionLabel.textAlignment = .left
        versionLabel.text = "Version"
        self.view.addSubview(versionLabel)
                
        // Setup 'verNumLabel' label.
        pos = screenWidth - (screenWidth / 4) - 30
        let verNumLabel = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        verNumLabel.center = CGPoint(x: pos, y: 120)
        verNumLabel.textAlignment = .right
        verNumLabel.text = "1.0"
        self.view.addSubview(verNumLabel)
        
        // Setup About Identaxy label.
        pos = screenWidth / 2
        let descriptionLabel = UILabel(frame: CGRect(x: pos, y: 40, width: 325, height: 200))
        descriptionLabel.textColor = UIColor.gray
        descriptionLabel.font = UIConstants.AVENIR_NEXT_REGULAR_15
        descriptionLabel.center = CGPoint(x: pos, y: 250)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.text = "identaxy is a mobile application that allows user's input to decide if a picture presented to them is a real galaxy photo by swiping right or left. Your input contributes to the Astrophysics department at The University of Texas at Austin and we appreciate every swipe you make."
        self.view.addSubview(descriptionLabel)
    }
    

}
