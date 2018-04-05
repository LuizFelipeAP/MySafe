//
//  PersistenceService.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class KeychainPersistence: PersistenceProtocol {
    
    //MARK: - Properties
    static var shared: KeychainPersistence = {
        return KeychainPersistence()
    }()
    
    struct Constants {
        static let key: String = "ACCOUNTS"
    }
    
    private init() { }
    
    //MARK: - Methods
    func add(account: Account) -> Bool {
        var saved: Bool = false
        
        var accounts = self.getAll()
        
        if !accounts.contains(account) {
            accounts.append(account)
            saved = self.add(all: accounts)
        }
        
        return saved
    }
    
    func remove(account: Account) -> Bool {

        var accounts = self.getAll()
        
        guard let indexToRemove = accounts.index(where: { $0 == account }) else { return false }
    
        accounts.remove(at: indexToRemove)
        
        return self.add(all: accounts)
    }
    
    func getAll() -> [Account] {
        
        let contains: Data? = KeychainWrapper.standard.data(forKey: Constants.key)
        
        guard let data = contains else {
            return []
        }
        
        guard let accounts: [Account] = try? JSONDecoder().decode([Account].self, from: data) else {
            return []
        }
        
        return accounts
    }
    
    func add(all accounts: [Account]) -> Bool {
        
        let d = try! JSONEncoder().encode(accounts)
        let saved = KeychainWrapper.standard.set(d, forKey: Constants.key)
        
        return saved
    }

}
