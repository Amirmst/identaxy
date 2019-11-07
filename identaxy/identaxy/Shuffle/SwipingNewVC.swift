//
//  SwipingNewVC.swift
//  identaxy
//
//  Created by Paul Purifoy on 11/6/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import Shuffle_iOS
import PopBounceButton

class SwipingNewVC: UIViewController {
    private let cardStack = SwipeCardStack()
    
    let alertService = AlertService()
    
    @IBOutlet weak var identaxyLabel: UILabel!
    @IBOutlet weak var nopeButton: UIButton!
    
    
    private let cardModels = [
        CardModel(image: UIImage(named: "User Pic")),
        CardModel(image: UIImage(named: "User Pic1")),
        CardModel(image: UIImage(named: "User Pic2")),
        CardModel(image: UIImage(named: "User Pic3")),
        CardModel(image: UIImage(named: "User Pic4")),
        CardModel(image: UIImage(named: "User Pic5")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardStack.delegate = self
        cardStack.dataSource = self
        
        layoutCardStackView()
        overrideUserInterfaceStyle = .dark
        identaxyLabel.textColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    private func layoutCardStackView() {
        view.addSubview(cardStack)
        cardStack.anchor(top: identaxyLabel.bottomAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: nopeButton.topAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let alertVC = alertService.alert(title: "Information", message: "Identaxy Information Popup", button: "OK")
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func nopePressed(_ sender: Any) {
        cardStack.swipe(.left, animated: true)
    }
    
    @IBAction func undoPressed(_ sender: Any) {
        cardStack.undoLastSwipe(animated: true)
    }
    
    @IBAction func yepPressed(_ sender: Any) {
        cardStack.swipe(.right, animated: true)
    }
}

extension SwipingNewVC: SwipeCardStackDataSource, SwipeCardStackDelegate {
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        
        return Card(model: cardModels[index])
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return cardModels.count
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        cardStack.reloadData()
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print("Undo \(direction) swipe on \(cardModels[index])")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        print("Swiped \(direction) on \(cardModels[index])")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("Card tapped")
    }
    
}
