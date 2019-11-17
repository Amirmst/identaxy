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
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

enum Response : String {
    case REAL
    case FAKE
    case UNSPECIFIED
}

protocol ColorMode {
    func adjustColor()
}

class SwipingNewVC: UIViewController, ColorMode {
    let path: String = "images/"
    static let kLoadCount: Int = 6
    
    private let cardStack = SwipeCardStack()
    let alertService = AlertService()
    let storage = Storage.storage()
    
    
    @IBOutlet weak var identaxyLabel: UILabel!
    @IBOutlet weak var nopeButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var yepButton: UIButton!

    var database: DatabaseReference!
    
    var images: Array<IdentaxyImage> = Array<IdentaxyImage>(repeating: IdentaxyImage(), count: kLoadCount)
    var responses: [String : Response] = [:]
    var numLoaded: Int = 0
    var imagesLoaded: Bool = false {
        didSet {
            self.createLoadingImageView()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.cardStack.reloadData()
            }
        }
    }
    let bgTaskQueue = DispatchQueue(label: "responseStoring", qos: .background)
    
    func setColorMode() {
        //super.setColorMode()
        let darkModeOn = UserDefaults.standard.bool(forKey:"darkModeOn")
        if(darkModeOn) {
            overrideUserInterfaceStyle = .dark
            self.view.backgroundColor = UIColor.black
            identaxyLabel.textColor = UIColor.white
            // Dark mode is on.
            let nope = UIImage(named: "Nope")
            let yep = UIImage(named: "Yep")
            let undo = UIImage(named: "Undo")
            
            nopeButton.setImage(nope, for: .normal)
            yepButton.setImage(yep, for: .normal)
            undoButton.setImage(undo, for: .normal)
        } else {
            overrideUserInterfaceStyle = .light
            self.view.backgroundColor = UIConstants.IDENTAXY_WHITE
            identaxyLabel.textColor = UIColor.black
            let nope = UIImage(named: "Nope_light_1")
            let yep = UIImage(named: "Yep_light_1")
            let undo = UIImage(named: "Undo_light_1")
            
            nopeButton.setImage(nope, for: .normal)
            yepButton.setImage(yep, for: .normal)
            undoButton.setImage(undo, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setColorMode()
        database = Database.database().reference()
        cardStack.delegate = self
        cardStack.dataSource = self
        
        layoutCardStackView()
        
        //print(UserDefaults.standard.string(forKey: "firstName")!)
        //print(UserDefaults.standard.string(forKey: "lastName")!)
        // Do any additional setup after loading the view.
        loadImages()
    }
    
    func loadImages() {
        let storageRef = storage.reference()

        for i in 0..<SwipingNewVC.kLoadCount {
            let picRef = storageRef.child("\(path)\(i).png")
            picRef.getData(maxSize: INT64_MAX) { (data, error) in
                if let error = error {
                    print("***ERROR*** PIC:\(i) " + error.localizedDescription)
                } else {
                    self.numLoaded += 1
                    let image = UIImage(data: data!)
                    self.images[i] = IdentaxyImage(imageObject: image!, imageId: "\(i)")
                    if (self.numLoaded == self.images.count) {
                        self.imagesLoaded = true
                        self.numLoaded = 0
                    }
                }
            }
        }
    }
    
    func storeResponses() {
        let mapCopy = responses
        let uid = Auth.auth().currentUser?.uid
        for (imageId, response) in mapCopy {
            let json = ["response": response.rawValue] as [String : String]
            self.database.child("responses").child(uid!).child(imageId).setValue(json)
        }
    }
    
    private func layoutCardStackView() {
        view.addSubview(cardStack)
        cardStack.anchor(top: identaxyLabel.bottomAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: nopeButton.topAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let alertVC = alertService.alert(title: "Swiping Information", message: "Swipe Right 👉🏻 REAL\nSwipe Left 👉🏿 FAKE\nSwipe Up 👉 UNSURE", button: "OK")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsSegue",
            let navVC = segue.destination as? UINavigationController {
            let nextVC = navVC.viewControllers.first as! SettingsVC
                nextVC.delegate = self
        }
    }
    
    func adjustColor() {
        self.setColorMode()
    }
}

extension SwipingNewVC: SwipeCardStackDataSource, SwipeCardStackDelegate {
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return Card(model: CardModel(image: images[index].getImage()))
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return images.count
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("RELOAD")
        bgTaskQueue.async {
            self.storeResponses()
        }
        loadImages()
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print("Undo \(direction) swipe on \(images[index].getId())")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        print("Swiped \(direction) on \(images[index].getId())")
        let imageId = images[index].getId()
        var response = Response.UNSPECIFIED
        switch direction {
        case .right:
            response = .REAL
        case .left:
            response = .FAKE
        case .up:
            response = .UNSPECIFIED
        default:
            response = .UNSPECIFIED
        }
        print("ID: \(imageId): \(response.rawValue)")
        responses[imageId] = response
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("Card tapped")
    }

    // MARK: loading indicator
    func createLoadingImageView() {
        let child = ImageViewController()
        DispatchQueue.main.async {
            child.view.frame = super.view.frame
            super.view.addSubview(child.view)
            child.view.superview?.bringSubviewToFront(child.view)
            child.didMove(toParent: self)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}

