//
//  SettingsVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/20/19.
//  Copyright © 2019 Ailyn Aguirre. All rights reserved.
//

import UIKit

class SettingsVC: IdentaxyHeader, UITableViewDataSource {
    
    let settingsTableView = UITableView()

    private let settings = SettingAPI.getSettings()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingsTableViewCell
        cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
        cell.setting = settings[indexPath.row]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
        // Create Logout button and view it will go in.
        //let button = PillShapedButton()
        let button = UIButton()
        let buttonView = UIView(frame: CGRect(x: 0, y: 800, width: 200, height: 50))

        // Constraints.
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("LOG OUT", for: .normal)
        button.backgroundColor = UIConstants.IDENTAXY_PINK
        button.center = self.view.center
        
        buttonView.addSubview(button)
        
        view.addSubview(buttonView)
        button.centerXAnchor.constraint(equalTo:buttonView.centerXAnchor).isActive = true
        
//        buttonView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant:40).isActive = true
         buttonView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        buttonView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        //self.settingsTableView.layoutMargins
        self.settingsTableView.rowHeight = 50
        self.settingsTableView.separatorColor = UIConstants.IDENTAXY_GRAY
        self.settingsTableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 20)
        view.addSubview(settingsTableView)
//        NSLayoutConstraint.activate([
//
//        ])
        settingsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        settingsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        settingsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo:buttonView.topAnchor, constant: -10).isActive = true
        settingsTableView.dataSource = self
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "settingCell")
        settingsTableView.alwaysBounceVertical = false  // No scroll
        
        self.setHeaderTitle(title: "Settings")
        
        
        
        //create a button or any UIView and add to subview
//        let button=UIButton.init(type: .system)
//        button.setTitle("NEXT", for: .normal)
//        button.frame.size = CGSize(width: 100, height: 50)
//        self.view.addSubview(button)

        //set constrains

        
//        let logoutButton = PillShapedButton()
//        logoutButton.titleLabel?.text = "LOG OUT"
//        self.view.addSubview(logoutButton)
//
//        logoutButton.translatesAutoresizingMaskIntoConstraints = false
//
//        logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        logoutButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        logoutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
    }
    
    

}
