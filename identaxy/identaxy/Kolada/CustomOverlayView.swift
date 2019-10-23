//
//  CustomOverlayView.swift
//  identaxy
//
//  Created by Kevin Nguyen on 10/20/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "real"
private let overlayLeftImageName = "fake"

class CustomOverlayView: OverlayView {

    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
        
        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        return imageView
        }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var overlayState: SwipeResultDirection?  {
        didSet {
            switch overlayState {
            case .left? :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right? :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
            
        }
    }
}
