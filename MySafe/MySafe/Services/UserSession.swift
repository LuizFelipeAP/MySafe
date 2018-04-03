//
//  UserSession.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class UserSession {
    
    static var shared: UserSession = {
        return UserSession()
    }()
    
    var user: User?
    var token: String?
    
    private init() { }
}
