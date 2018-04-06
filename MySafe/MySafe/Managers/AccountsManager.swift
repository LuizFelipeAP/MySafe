//
//  AccountsManager.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class AccountsManager {
    
    //MARK: - Properties
    var accounts: [Account] = []
    
    var grouped: [String: [Account]] = [:]
    
    var sections: [String] = []
    
    var rowsPerSection: [Int] = []
    
    //MARK: - Methods
    
    func fetchAccounts() {
        //Retrive all accounts from keychain
        self.accounts = KeychainPersistence.shared.getAllAccounts()
        
        //Group the accounts by the application
        self.grouped = self.groupByName()
        
        //Set up the array of section
        self.sections = Array<String>(self.grouped.keys)
            .sorted(by: { $0 < $1 })
        
        //Set up the number of rows for each section
        self.rowsPerSection = self.sections.map {
            return self.grouped[$0]?.count ?? 0
        }
    }
    
    func groupByName() -> [String: [Account]] {
        
        var groups: [String: [Account]] = [:]
        
        self.accounts.forEach {
            
            var accountsList = groups[$0.application] ?? []
            
            accountsList.append($0)
            
            groups[$0.application] = accountsList
        }
        
        return groups
    }
    
    
}
