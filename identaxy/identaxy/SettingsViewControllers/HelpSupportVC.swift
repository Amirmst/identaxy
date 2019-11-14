//
//  HelpSupportVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit
import Foundation

struct HelpOpt {
    let label:String?
}

class HelpAPI {
    static func getHelpOpts() -> [HelpOpt]{
        let helpOpts = [
            HelpOpt(label: "Report a bug"),
            HelpOpt(label: "Contact us")
        ]
        return helpOpts
    }
}

class HelpCell: UITableViewCell {
    
    var cellButton: UIButton!
    var cellLabel: UILabel!
    
    init(frame: CGRect, title: String) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        //        cellLabel = UILabel(frame: CGRectMake(self.frame.width - 100, 10, 100.0, 40))
        //        cellLabel.textColor = UIColor.blackColor
        //        cellLabel.font = //set font here
        
        //        cellButton = UIButton(frame: CGRectMake(5, 5, 50, 30))
        //        cellButton.setTitle(title, forState: UIControlState.Normal)
        
        //        addSubview(cellLabel)
        //        addSubview(cellButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    //        super.init(style: style, reuseIdentifier: reuseIdentifier)
    //    }
}

class HelpSupportVC: IdentaxyHeader, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: UIViewController!
    let reportBugSegueIdentifier = "reportBugSegue"
    let contactUsSegueIdentifier = "contactUsSegue"
    
    @IBOutlet weak var optionsTableView: UITableView!
    //    var opts = ["Report a problem", "Contact Us"]
    private let opts = HelpAPI.getHelpOpts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeaderTitle(title: "Help & Support")
        super.setColorMode()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
        // Constraints.
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        //self.settingsTableView.layoutMargins
        self.optionsTableView.rowHeight = 50
        self.optionsTableView.separatorColor = UIConstants.IDENTAXY_GRAY
        self.optionsTableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 20)
        view.addSubview(optionsTableView)
        optionsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        optionsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        optionsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        optionsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -10).isActive = true
        optionsTableView.dataSource = self
        
        // Register Static cell names for segue to different VC's
        optionsTableView.register(HelpOptTableViewCell.self, forCellReuseIdentifier: "reportBugCell")
        optionsTableView.register(HelpOptTableViewCell.self, forCellReuseIdentifier: "contactUsCell")
        
        //        optionsTableView.alwaysBounceVertical = false  // No scroll
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        opts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reportBugCell", for: indexPath) as! HelpOptTableViewCell
            cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
            cell.help = opts[indexPath.row]
            return cell
        } else if(indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactUsCell", for: indexPath) as! HelpOptTableViewCell
            cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
            cell.help = opts[indexPath.row]
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingsTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath), let identifier = cell.reuseIdentifier {
            var segueID = ""
            switch identifier {
            case "reportBugCell":
                segueID = "reportBugSegue"
            case "contactUsCell":
                segueID = "contactUsSegue"
            default:
                print("Should not ever reach here")
                return
            }
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: segueID, sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == reportBugSegueIdentifier {
            let nextVC = segue.destination as! ReportBugVC
            nextVC.delegate = self
            
        } else if segue.identifier == contactUsSegueIdentifier {
            let nextVC = segue.destination as! ContactUsVC
            nextVC.delegate = self
            
        }
    }
    
}
