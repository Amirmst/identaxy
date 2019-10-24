//
//  HelpOptTableViewCell.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

class HelpOptTableViewCell: UITableViewCell {

    var help:HelpOpt? {
        didSet {
            guard let helpItem = help else {return}
                if let label = helpItem.label {
                    titleLabel.text = label
                }
        }
    }
    
    // Name of setting.
    let titleLabel:UILabel = {
            let label = UILabel()
            label.font = UIConstants.ROBOTO_REGULAR
            label.textColor =  UIColor.white
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
        titleLabel.font = UIConstants.AVENIR_NEXT_REGULAR_15
        self.tintColor = UIConstants.IDENTAXY_LIGHT_PINK
            self.accessoryType = .disclosureIndicator
            // Add the views to the cell.
            containerView.addSubview(titleLabel)
            self.contentView.addSubview(containerView)
            self.contentView.addSubview(titleLabel)
            
            // Container view constraints.
            containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:25).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-70).isActive = true
            containerView.heightAnchor.constraint(equalToConstant:50).isActive = true
            
            // Title label constraints.
            titleLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
            
        }
         required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
        }
    
}

