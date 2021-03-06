//
//  SettingsTableViewCell.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/20/19.
//  Copyright © 2019 Ailyn Aguirre. All rights reserved.
//

// From https://softauthor.com/ios-uitableview-programmatically-in-swift/#create-model-struct-and-class-files

import UIKit

class SettingsTableViewCell: UITableViewCell {

    var setting:Setting? {
        didSet {
            guard let settingItem = setting else {return}
            if let name = settingItem.name {
                nameLabel.text = name  // Name of setting.
                if (name == "About") {
                    self.accessoryType = .detailButton
                } else if (name != "Dark Mode") {
                    self.accessoryType = .disclosureIndicator
                }
            }
            if let img = settingItem.img {
                leftImageView.image = UIImage(named: img)
            }

        }
    }
    
    // Left image.
    let leftImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
       return img
    }()
    
    // Name of setting.
    var nameLabel:UILabel = {
            let label = UILabel()
            label.font = UIConstants.ROBOTO_REGULAR
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel.font = UIConstants.AVENIR_NEXT_REGULAR_15
        self.tintColor = UIConstants.IDENTAXY_PINK

        // Add the views to the cell.
        self.contentView.addSubview(leftImageView)
        containerView.addSubview(nameLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(nameLabel)
        
        // Auto constraints for each view.
        leftImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        leftImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:25).isActive = true
        leftImageView.widthAnchor.constraint(equalToConstant:30).isActive = true
        leftImageView.heightAnchor.constraint(equalToConstant:30).isActive = true
        
        // Container view constraints.
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.leftImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-70).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        // Name label constraints.
        nameLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
    }
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}
