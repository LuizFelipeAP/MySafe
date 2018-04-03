//
//  APIResponse.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class APIResponse: Codable {
    let type: String
    let token: String?
    let message: String?
    let errors: [String]?
    
    var success: Bool {
        get {
            return self.type == "sucess"
        }
    }
    
    init(type: String,
         token: String? = nil,
         message: String? = nil,
         errors: [String]? = nil) {
        self.type = type
        self.token = token
        self.message = message
        self.errors = errors
    }
}
