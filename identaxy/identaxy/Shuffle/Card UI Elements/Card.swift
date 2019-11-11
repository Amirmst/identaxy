//
//  Card.swift
//  ShuffleExample
//
//  Created by Mac Gallagher on 7/12/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import Shuffle_iOS
class Card: SwipeCard {
    
    override var swipeDirections: [SwipeDirection] {
        return [.left, .right, .up]
    }
    
    init(model: CardModel) {
        super.init(frame: .zero)
        initialize()
        configure(model: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func initialize() {
        footerHeight = 80
    }
    
    override func overlay(forDirection direction: SwipeDirection) -> UIView? {
        switch direction {
        case .left:
            return CardOverlay.left()
        case .up:
            return CardOverlay.up()
        case.right:
            return CardOverlay.right()
        default:
            return nil
        }
    }
    private func configure(model: CardModel) {
        content = CardContentView(image: model.image)
//        footer = CardFooterView(title: "\(model.name), \(model.age)", subtitle: model.occupation)
    }
}
