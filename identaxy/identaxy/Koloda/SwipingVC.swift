//
//  SwipingVC.swift
//  identaxy
//
//  Created by Kevin Nguyen on 10/20/19.
//  Copyright © 2019 amir. All rights reserved.
//
//
//  BackgroundAnimationViewController.swift
//  Koloda
//
//  Created by Eugene Andreyev on 7/11/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Koloda
import pop
import FirebaseStorage

private let numberOfCards: Int = 5
private let frameAnimationSpringBounciness: CGFloat = 9
private let frameAnimationSpringSpeed: CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent: CGFloat = 0

let path: String = "images/sample_pic_"


class SwipingVC: UIViewController {

    var images: [UIImage] = []
    
    @IBOutlet weak var identaxyLabel: UILabel!
    @IBOutlet weak var kolodaView: CustomKolodaView!
    
    var user: User!
    
    let storage = Storage.storage()
    
    let alertService = AlertService()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
        identaxyLabel.textColor = UIColor.white
        overrideUserInterfaceStyle = .dark
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        print("LOADING VIEW")
        loadImages()
    }
    
    func loadImages() {
        let storageRef = storage.reference()

        for i in 0...5 {
            let picRef = storageRef.child("images/\(i).png")
            picRef.getData(maxSize: INT64_MAX) { (data, error) in
                if let error = error {
                    print("***ERROR*** PIC:\(i) " + error.localizedDescription)
                } else {
                    print("***SUCCESS*** PIC:\(i)")
                    let image = UIImage(data: data!)
                    self.images.append(image!)
                }
            }
        }
    }
    
    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(.right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let alertVC = alertService.alert(title: "Information", message: "Identaxy Information Popup", button: "OK")
        present(alertVC, animated: true, completion: nil)
    }
}

//MARK: KolodaViewDelegate
extension SwipingVC: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        print("RELOAD")
        loadImages()
        kolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
//        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
}

// MARK: KolodaViewDataSource
extension SwipingVC: KolodaViewDataSource {
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return numberOfCards
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: UIImage(named: "User Pic\(index + 1)"))
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
