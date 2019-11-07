//
//  IdentaxyImage.swift
//  identaxy
//
//  Created by Amir Mostafavi on 11/6/19.
//  Copyright © 2019 amir. All rights reserved.
//

import Foundation
import UIKit

// class representing an image an its ID.
class IdentaxyImage {
    private let imageObject: UIImage
    private let imageId: String
    
    init() {
        imageObject = UIImage()
        imageId = String()
    }
    
    init(imageObject: UIImage, imageId: String) {
        self.imageObject = imageObject
        self.imageId = imageId
    }
    
    func getImage() -> UIImage {
        return imageObject
    }
    
    func getId() -> String {
        return imageId
    }
}
