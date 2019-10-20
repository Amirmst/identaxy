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
        cell.backgroundColor = UIColor.black
        cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
        cell.setting = settings[indexPath.row]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTableView.rowHeight = 50
        self.settingsTableView.backgroundColor = UIColor.black
        view.addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        settingsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        settingsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        settingsTableView.dataSource = self
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "settingCell")
        self.setHeaderTitle(title: "Settings")
    }

}
