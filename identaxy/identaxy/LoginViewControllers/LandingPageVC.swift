//
//  ViewController.swift
//  identaxy
//
//  Created by Amir Mostafavi on 10/1/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LandingPageVC: IdentaxyHeader {

    @IBOutlet weak var signupButton: PillShapedButton!
    @IBOutlet weak var loginButton: UIButton!
    var database: DatabaseReference!

    override func viewDidLoad() {
        overrideUserInterfaceStyle = .dark
        database = Database.database().reference()

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButtonSetup()
        super.setColorMode()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            self.database.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
                let value = snapshot.value as? NSDictionary
                let firstName = value?["first_name"] as? String ?? ""
                let lastName = value?["last_name"] as? String ?? ""
                
                let userData = User(firstName: firstName, lastName: lastName)
                self.showSwipeVCWithLeftToRightTransition(swipeVCId: "Swipe-Screen", user: userData)
            })
        }
        
    }
    
    private func loginButtonSetup() {
        loginButton.titleLabel?.font = UIConstants.ROBOTO_REGULAR
        loginButton.setTitleColor(UIConstants.IDENTAXY_PINK, for: .normal)
        loginButton.setTitleColor(UIConstants.IDENTAXY_LIGHT_PINK, for: .selected)
        loginButton.setTitleColor(UIConstants.IDENTAXY_LIGHT_PINK, for: .highlighted)
    }
    
    // MARK: - UI Methods
    func showSwipeVCWithLeftToRightTransition(swipeVCId: String, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: swipeVCId) as! SwipingNewVC
        
        let rightToLeft = CATransition()
        rightToLeft.duration = 0.5
        rightToLeft.type = CATransitionType.push
        rightToLeft.subtype = CATransitionSubtype.fromRight
        rightToLeft.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(rightToLeft, forKey: kCATransition)
        
        controller.modalPresentationStyle = .overFullScreen
        self.present(controller, animated: false, completion: nil)
    }
}

