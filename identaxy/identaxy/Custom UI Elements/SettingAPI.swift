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
}

class SettingAPI {
 static func getSettings() -> [Setting]{
   let settings = [
     Setting(name: "Dark Mode"),
     Setting(name: "Email address"),
     Setting(name: "Password"),
     Setting(name: "Help & Support"),
     Setting(name: "About")
    ]
   return settings
  }
}
