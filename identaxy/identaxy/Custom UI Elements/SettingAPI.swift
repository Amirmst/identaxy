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
    let btnStr:String?
}

class SettingAPI {
 static func getSettings() -> [Setting]{
   let settings = [
    Setting(name: "Dark Mode", img: "night-mode", btnStr: " "),
    Setting(name: "Email address", img: "mail-icon", btnStr: ">"),
    Setting(name: "Password", img: "password", btnStr: ">"),
     Setting(name: "Help & Support", img: "help-support", btnStr: ">"),
     Setting(name: "About", img: "about", btnStr: ">")
    ]
   return settings
  }
}
