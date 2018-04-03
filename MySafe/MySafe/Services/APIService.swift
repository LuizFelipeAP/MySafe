//
//  APIService.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    static var shared: APIService = {
        return APIService()
    }()
    
    private init() { }
    
    //MARK: - Methods
    func authenticate(user: User,
                      completion: @escaping (APIResponse) -> (Void)) {
        
    }
    
    func postNew(user: User,
                 completion: @escaping (APIResponse) -> (Void)) {
        
    }
    
}
