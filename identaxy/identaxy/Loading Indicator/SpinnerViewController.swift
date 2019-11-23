//
//  SpinnerViewController.swift
//  identaxy
//
//  Created by Cepak, Alexandria N on 11/7/19.
//  Copyright © 2019 amir. All rights reserved.
//
import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spinner.color = UIColor(red: 235/255, green: 90/255, blue: 233/255, alpha: 1)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

class ImageViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image!)
        
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(lessThanOrEqualTo: imageView.superview!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(lessThanOrEqualTo: imageView.superview!.centerYAnchor).isActive = true
    }
}
