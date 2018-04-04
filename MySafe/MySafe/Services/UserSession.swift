//
//  UserSession.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
import Kingfisher

class UserSession {
    
    static var shared: UserSession = {
        return UserSession()
    }()
    
    var user: User?
    var token: String? = "11bd7a1e-84ab-440b-a81e-68452f9554e0"
    
    private init() { }
    
    var kingfisherModifier: KingfisherOptionsInfoItem {
    
        let modifier = AnyModifier { request in
            
            var mutableRequest = request
            mutableRequest.setValue(UserSession.shared.token, forHTTPHeaderField: "authorization")
            return mutableRequest
        }
        
        let modifierItem = KingfisherOptionsInfoItem.requestModifier(modifier)
        
        return modifierItem
    }
}
