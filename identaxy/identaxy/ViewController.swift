//
//  ViewController.swift
//  identaxy
//
//  Created by Cepak, Alexandria N on 11/7/19.
//  Copyright © 2019 amir. All rights reserved.
//

import Foundation
import UIKit
import SwiftyGif

class ViewController: UIViewController {

    let logoAnimationView = LogoAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoAnimationView)
//        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }

}

extension ViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
    }
}
