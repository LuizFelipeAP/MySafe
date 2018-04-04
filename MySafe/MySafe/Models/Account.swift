//
//  Account.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class Account: Codable {
    
    var application: String
    var username: String
    var passcode: String
    
    init(application: String = "www.site.com",
         username: String = "username",
         passcode: String = "passcode") {
        
        self.application = application
        self.username = username
        self.passcode = passcode
    }
}
