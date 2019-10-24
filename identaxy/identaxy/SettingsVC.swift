//
//  SettingsVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/20/19.
//  Copyright © 2019 Ailyn Aguirre. All rights reserved.
//

import UIKit



class SettingsVC: IdentaxyHeader, UITableViewDelegate, UITableViewDataSource {
    
    let emailSegueIdentifier = "emailSegue"
    let passwordSegueIdentifier = "passwordSegue"
    let helpSegueIdentifier = "helpSegue"
    let aboutSegueIdentifier = "aboutSegue"
    
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var logoutButton: PillShapedButton!
    private let settings = SettingAPI.getSettings()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "darkModeCell", for: indexPath) as! SettingsTableViewCell
            cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
            cell.setting = settings[indexPath.row]
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(true, animated: true)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.accessoryView = switchView
            cell.rightButtonView.setTitle(" ", for: .normal)
            cell.selectionStyle = .none
            return cell
        } else if(indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath) as! SettingsTableViewCell
            cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
            cell.setting = settings[indexPath.row]
            return cell
        } else if(indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "passwordCell", for: indexPath) as! SettingsTableViewCell
            cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
            cell.setting = settings[indexPath.row]
            return cell
        } else if(indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "helpCell", for: indexPath) as! SettingsTableViewCell
            cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
            cell.setting = settings[indexPath.row]
            return cell
        } else if(indexPath.row == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath) as! SettingsTableViewCell
            cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
            cell.setting = settings[indexPath.row]
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingsTableViewCell
    }
    
    // To set dark/light mode.
    @objc func switchChanged(_ sender : UISwitch!) {
        if(sender.isOn) {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeaderTitle(title: "Settings")
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        overrideUserInterfaceStyle = .dark
        
        // Create Logout button and view it will go in.
        //let button = PillShapedButton()
//        let button = UIButton()
        let buttonView = UIView(frame: CGRect(x: 0, y: 800, width: 500, height: 1000))

        // Constraints.
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        logoutButton.setTitle("LOG OUT", for: .normal)
        logoutButton.backgroundColor = UIConstants.IDENTAXY_PINK
        logoutButton.center = self.view.center
        
        buttonView.addSubview(logoutButton)
        
        logoutButton.centerXAnchor.constraint(equalTo:buttonView.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(lessThanOrEqualToConstant: 394).isActive = true
        
        UIGraphicsBeginImageContext(CGSize(width: 300, height: 40))
        if let context = UIGraphicsGetCurrentContext() {
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            logoutButton.setBackgroundImage(colorImage, for: .normal)
        }

        
        view.addSubview(buttonView)

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
        
        // Register Static cell names for segue to different VC's
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "settingCell")
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "darkModeCell")
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "emailCell")
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "passwordCell")
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "helpCell")
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "aboutCell")
        
        settingsTableView.alwaysBounceVertical = false  // No scroll
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath), let identifier = cell.reuseIdentifier {
            var segueID = ""
            switch identifier {
                case "emailCell":
                    segueID = "emailSegue"
                case "passwordCell":
                    segueID = "passwordSegue"
                case "helpCell":
                    segueID = "helpSegue"
                case "aboutCell":
                    segueID = "aboutSegue"
                default:
                    print("Should not ever reach here")
                    return
            }
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: segueID, sender: self)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == emailSegueIdentifier {
            let nextVC = segue.destination as! UpdateEmailVC
            nextVC.delegate = self

        } else if segue.identifier == passwordSegueIdentifier {
            let nextVC = segue.destination as! UpdatePasswordVC
            nextVC.delegate = self

        } else if segue.identifier == helpSegueIdentifier {
            let nextVC = segue.destination as! HelpSupportVC
            nextVC.delegate = self

        } else if segue.identifier == aboutSegueIdentifier {
            let nextVC = segue.destination as! AboutVC
            nextVC.delegate = self
        }
    }
}
