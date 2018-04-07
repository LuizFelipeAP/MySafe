//
//  AccountsManagerTests.swift
//  MySafeTests
//
//  Created by Luiz Felipe Albernaz Pio on 06/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Quick
import Nimble

@testable import MySafe

class AccountsManagerTests: QuickSpec {

    
    override func spec() {
        
        var accountsManager: AccountsManager!
        
        beforeEach {
            let persistenceService = KeychainPersistenceMock()
            accountsManager = AccountsManager(persistenceService: persistenceService)
        }
        
        describe("testing accounts manager") {
            
            context("fetch of data") {
                
                it("should pass") {
                    
                    //Arrange & Act
                    accountsManager.fetchAccounts()
                    
                    //Assert
                    expect(accountsManager.accounts.count) == 3
                    expect(accountsManager.grouped.count) == 2
                    expect(accountsManager.rowsPerSection[0]) == 1
                    expect(accountsManager.rowsPerSection[1]) == 2
                }
                
            }
        }
    }
    
    
}
