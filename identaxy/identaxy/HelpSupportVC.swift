//
//  HelpSupportVC.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/24/19.
//  Copyright © 2019 amir. All rights reserved.
//

import UIKit

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

class HelpSupportVC: IdentaxyHeader, UITableViewDataSource {
    
    var delegate: UIViewController!

    @IBOutlet weak var optionsTableView: UITableView!
    var opts = ["Report a problem", "Contact Us"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeaderTitle(title: "Help & Support")
        overrideUserInterfaceStyle = .dark

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        opts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "helpCell", for: indexPath) as! HelpCell
        cell.textLabel?.font = UIConstants.ROBOTO_REGULAR
        //cell.setting = opts[indexPath.row]
        return cell
    }
    
}
