//
//  Account.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class Account: NSObject, Codable {
    
    var application: String
    var username: String
    var passcode: String
    
    override var description: String {
        return "Application: \(self.application) - Username: \(self.username)"
    }
    
    init(application: String = "www.site.com",
         username: String = "username",
         passcode: String = "passcode") {
        
        self.application = application
        self.username = username
        self.passcode = passcode
    }
}

//**************************************************************************************
//
// MARK: - Equatable Extension
//
//**************************************************************************************
extension Account {
    
    static func ==(lhs: Account, rhs: Account) -> Bool {
        return lhs.application == rhs.application && lhs.username == rhs.username
    }
    
}
