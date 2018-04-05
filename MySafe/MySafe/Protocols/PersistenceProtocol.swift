//
//  PersistenceProtocol.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

protocol PersistenceProtocol {
    func add(account: Account) -> Bool
    func update(account: Account) -> Bool
    func remove(account: Account) -> Bool
    func getAll() -> [Account]
    func add(all accounts: [Account]) -> Bool
}
