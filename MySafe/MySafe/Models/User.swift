//
//  User.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class User: NSObject {

    let name: String
    let username: String
    let passcode: String
    var accounts: [Account]
    
    init(name: String = "Mock",
         username: String = "mock@mail.com",
         passcode: String = "Mock@#3456",
         accounts: [Account] = []) {
        self.name = name
        self.username = username
        self.passcode = passcode
        self.accounts = accounts
        
        super.init()
    }
}
