//
//  SettingAPI.swift
//  identaxy
//
//  Created by Ailyn Aguirre on 10/20/19.
//  Copyright © 2019 Ailyn Aguirre. All rights reserved.
//

import Foundation

struct Setting {
    let name:String?
    let img:String?
}

class SettingAPI {
 static func getSettings() -> [Setting]{
   let settings = [
                    Setting(name: "Dark Mode", img: "night-mode"),
                    Setting(name: "Email address", img: "mail-icon"),
                    Setting(name: "Password", img: "password"),
                    Setting(name: "Help & Support", img: "help-support"),
                    Setting(name: "About", img: "about")
                  ]
   return settings
  }
}
