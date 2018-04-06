//
//  Account.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class Account: NSObject, Codable {
    
    var id: String
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
        
        self.id = UUID().uuidString
    }
}

//**************************************************************************************
//
// MARK: - Equatable Extension
//
//**************************************************************************************
extension Account {
    
    override func isEqual(_ object: Any?) -> Bool {
        return self.id == (object as? Account)?.id
    }
    
    /**
     Compares if all atributes are equals
     
     - parameters:
        - account: the account to compare
     
     - returns:
        A boolean value indicating if all attributes are equal
     
     */
    func veryEqual(to account: Account) -> Bool {
        return self.id == account.id
            && self.application == account.application
            && self.username == account.username
            && self.passcode == account.passcode
    }
    
}
