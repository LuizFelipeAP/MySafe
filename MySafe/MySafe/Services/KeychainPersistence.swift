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
        static let usersKey: String = "USERS"
    }
    
    private init() { }
}

//**************************************************************************************
//
// MARK: - Accounts Extension
//
//**************************************************************************************
extension KeychainPersistence {
    
    func add(account: Account) -> Bool {
        var saved: Bool = false
        
        var accounts = self.getAllAccounts()
        
        if !accounts.contains(account) {
            accounts.append(account)
            saved = self.add(all: accounts)
        }
        
        return saved
    }
    
    func update(account: Account) -> Bool {
        
        var accounts = self.getAllAccounts()
        
        guard let indexToEdit = accounts.index(where: { $0 == account }) else { return false }
        
        accounts[indexToEdit] = account
        
        return self.add(all: accounts)
    }
    
    func remove(account: Account) -> Bool {
        
        var accounts = self.getAllAccounts()
        
        guard let indexToRemove = accounts.index(where: { $0 == account }) else { return false }
        
        accounts.remove(at: indexToRemove)
        
        return self.add(all: accounts)
    }
    
    func getAllAccounts() -> [Account] {
        
        guard let key = UserSession.shared.user?.username else { return [] }
        
        let contains: Data? = KeychainWrapper.standard.data(forKey: key)
        
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
        
        guard let key = UserSession.shared.user?.username else { return false }
        
        let saved = KeychainWrapper.standard.set(d, forKey: key)
        
        return saved
    }
    
}

//**************************************************************************************
//
// MARK: - Users Extension
//
//**************************************************************************************
extension KeychainPersistence {
    
    @discardableResult
    func add(user: User) -> Bool {
        var saved: Bool = false
        
        var users = self.getAllUsers()
        
        if !users.contains(user) {
            users.append(user)
            saved = self.add(all: users)
        }
        
        return saved
    }
    
    func getAllUsers() -> [User] {
        
        let contains: Data? = KeychainWrapper.standard.data(forKey: Constants.usersKey)
        
        guard let data = contains else {
            return []
        }
        
        guard let users: [User] = try? JSONDecoder().decode([User].self, from: data) else {
            return []
        }
        
        return users
        
    }
    
    func add(all users: [User]) -> Bool {
        
        let d = try! JSONEncoder().encode(users)
        
        let saved = KeychainWrapper.standard.set(d, forKey: Constants.usersKey)
        
        return saved
        
    }
    
}
