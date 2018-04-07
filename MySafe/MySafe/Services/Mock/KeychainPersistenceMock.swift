//
//  KeychainPersistenceMock.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 06/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class KeychainPersistenceMock: PersistenceProtocol {
    
    //My DB
    fileprivate var accounts: [Account]
    fileprivate var users: [User]
    
    init() {
        let accOne = Account(application: "netflix.com", username: "John", passcode: "John123")
        let accTwo = Account(application: "globo.com", username: "Peter", passcode: "Peter")
        let accThree = Account(application: "netflix.com", username: "Mary", passcode: "Mary123")
        
        self.accounts = [accOne, accTwo, accThree]
        
        let usrOne = User(name: "John", username: "john@mail.com", passcode: "Pass@12345")
        let usrTwo = User(name: "Peter", username: "peter@mail.com", passcode: "Pass@12345")
        let usrThree = User(name: "Mary", username: "mary@mail.com", passcode: "Pass@12345")
        
        self.users = [usrOne, usrTwo, usrThree]
    }
    
    func add(account: Account) -> Bool {
        
        if !self.accounts.contains(account) {
            self.accounts.append(account)
            return true
        }
        
        return false
    }
    
    func update(account: Account) -> Bool {
        
        guard let indexToEdit = self.accounts.index(where: { $0 == account }) else { return false }
        
        accounts[indexToEdit] = account
        
        return true
    }
    
    func remove(account: Account) -> Bool {
        
        guard let indexToDelete = self.accounts.index(of: account) else { return false }
        accounts.remove(at: indexToDelete)
        
        return true
    }
    
    func getAllAccounts() -> [Account] {
        return self.accounts
    }
    
    //
    func add(all accounts: [Account]) -> Bool {
        self.accounts.append(contentsOf: accounts)
        return true
    }
    
    func add(user: User) -> Bool {
        self.users.append(user)
        return true
    }
    
    func getAllUsers() -> [User] {
        return self.users
    }
    
    func add(all users: [User]) -> Bool {
        self.users.append(contentsOf: users)
        return true
    }
    

}
