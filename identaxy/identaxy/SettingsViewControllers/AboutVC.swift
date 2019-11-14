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
        self.setHeaderTitle(title: "About")
        super.setColorMode()
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        // Setup 'versionLabel' label.
        var pos = (screenWidth / 2) - (screenWidth / 4) + 30
        let versionLabel = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        versionLabel.center = CGPoint(x: pos, y: view.frame.origin.y + 30)
        versionLabel.textAlignment = .left
        versionLabel.text = "Version"
        self.view.addSubview(versionLabel)
        
        // create path

        let path = UIBezierPath()
        path.move(to: CGPoint(x: pos - versionLabel.frame.width / 2, y: view.frame.origin.y + 60))
        path.addLine(to: CGPoint(x: view.frame.origin.y + view.frame.width, y: view.frame.origin.y + 60))

        // Create a `CAShapeLayer` that uses that `UIBezierPath`:

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIConstants.IDENTAXY_LIGHT_PINK.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 0.5

        // Add that `CAShapeLayer` to your view's layer:

        view.layer.addSublayer(shapeLayer)
        
        // Setup 'verNumLabel' label.
        pos = screenWidth - (screenWidth / 4) - 30
        let verNumLabel = UILabel(frame: CGRect(x: pos, y: 5, width: 200, height: 21))
        verNumLabel.center = CGPoint(x: pos, y: view.frame.origin.y + 30)
        verNumLabel.textAlignment = .right
        verNumLabel.text = "0.2 β"
        self.view.addSubview(verNumLabel)
        
        // Setup About Identaxy label.
        pos = screenWidth / 2
        let descriptionLabel = UILabel(frame: CGRect(x: pos, y: 40, width: 325, height: 200))
        descriptionLabel.textColor = UIColor.gray
        descriptionLabel.font = UIConstants.AVENIR_NEXT_REGULAR_15
        descriptionLabel.center = CGPoint(x: pos, y: verNumLabel.center.y + 120)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.text = "identaxy is a mobile application that allows users to get involved in research by swiping left or right indicating whether a photo is a real photo or a fake one respectively. The input contributes to the Astrophysics department at The University of Texas at Austin and we appreciate every swipe you make. 💫"
       self.view.addSubview(descriptionLabel)
    }
    
    
}
