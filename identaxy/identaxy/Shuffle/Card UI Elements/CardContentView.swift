//
//  SampleCardContentView.swift
//  ShuffleExample
//
//  Created by Mac Gallagher on 11/14/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

class CardContentView: UIView {
    private let backgroundView: UIView = {
        let background = UIView()
        background.clipsToBounds = true
        background.layer.cornerRadius = 10
        return background
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0.01).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }()
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        imageView.image = image
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func initialize() {
        addSubview(backgroundView)
        backgroundView.anchorToSuperview()
        backgroundView.addSubview(imageView)
        imageView.anchorToSuperview()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let heightFactor: CGFloat = 0.35
//        gradientLayer.frame = CGRect(x: 0, y: (1 - heightFactor) * bounds.height,
//                                     width: bounds.width,
//                                     height: heightFactor * bounds.height)
    }
}
