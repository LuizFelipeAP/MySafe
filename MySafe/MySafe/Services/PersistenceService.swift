//
//  PersistenceService.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class KeychainPersistence: PersistenceProtocol {
    
    func add(account: Account) -> Bool {
        
        return true
    }
    
    func remove(account: Account) -> Bool {
        
        return true
    }
    
    func getAll() -> [Account] {
        
        return []
    }
    
    func add(all: [Account]) -> Bool {
        
        return true
    }

}
