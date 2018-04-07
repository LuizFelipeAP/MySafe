//
//  PersistenceProtocol.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

protocol PersistenceProtocol {
    
    //To manage the accounts persistence
    func add(account: Account) -> Bool
    func update(account: Account) -> Bool
    func remove(account: Account) -> Bool
    func getAllAccounts() -> [Account]
    func add(all accounts: [Account]) -> Bool
    
    //To manage the Users authenticated persistence
    @discardableResult
    func add(user: User) -> Bool
    func getAllUsers() -> [User]
    func add(all users: [User]) -> Bool
}
