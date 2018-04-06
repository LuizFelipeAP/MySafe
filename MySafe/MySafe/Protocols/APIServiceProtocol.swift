//
//  APIServiceProtocol.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 06/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func authenticate(user: User, completion: @escaping (APIResponse?) -> (Void))
    func postNew(user: User, completion: @escaping (APIResponse?) -> (Void))
    
    func parse(data: Data) -> APIResponse?
}
