//
//  User.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class User: NSObject, Codable {

    let name: String
    let username: String
    let passcode: String
    
    init(name: String = "Mock",
         username: String = "mock@mail.com",
         passcode: String = "Mock@#3456") {
        self.name = name
        self.username = username
        self.passcode = passcode
    }
}


//**************************************************************************************
//
// MARK: - Equatable Extension
//
//**************************************************************************************
extension User {
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
    }
}
