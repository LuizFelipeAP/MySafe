//
//  AccountDetailManagerTests.swift
//  MySafeTests
//
//  Created by Luiz Felipe Albernaz Pio on 06/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import MySafe

class AccountDetailManagerTests: QuickSpec {

    override func spec() {
        
        var accountDetailManager: AccountDetailManager!
        var originAccount: Account!
        
        beforeEach {
            
            let persistenceService = KeychainPersistenceMock()
            
            originAccount = persistenceService.getAllAccounts().first
            
            accountDetailManager = AccountDetailManager(account: originAccount,
                                 persistenceService: persistenceService)
            
        }
        
        describe("testing accountDetail manager") {
            
            context("remove an account") {
                
                it("shoud succeed") {
                    
                    //Act
                    let isDeleted = accountDetailManager.removeAccount()
                    
                    expect(isDeleted) == true
                }
            }
            
            context("check if account has changed") {
                
                it("should succeed") {
                    
                    //Arrange
                    let edditedAccount = Account(application: "youtube.com", username: "Sam", passcode: "Sam")
                
                    accountDetailManager.edditedAccount = edditedAccount
                    
                    //Act
                    let isEddited = accountDetailManager.isAccountEddited()
                    
                    //Assert
                    expect(isEddited) == true
                }
                
                //Fail because the accounts are equal
                it("should succeed") {
                    
                    //Arrange
                    
                    let eddited = Account(application: originAccount.application, username: originAccount.username, passcode: originAccount.passcode)
                    
                accountDetailManager.edditedAccount = eddited
                    
                    //Act
                    let isEddited = accountDetailManager.isAccountEddited()
                    
                    //Assert
                    expect(isEddited) == false
                }
            }
            
            context("edit an account") {
                
                it("should succeed") {
                    
                    //Arrange
                    let eddited = Account(application: "apple.com", username: "Steve", passcode: "richrich")
                    
                    accountDetailManager.edditedAccount = eddited
                    
                    //Act
                    let editStatus = accountDetailManager.editAccount()
                    
                    //Assert
                    expect(editStatus.0) == true
                }
                
                //Fail because is not valid
                it("should fail") {
                    
                    //Arrange
                    let eddited = Account(application: "s", username: "s", passcode: "r")
                    
                    accountDetailManager.edditedAccount = eddited
                    
                    //Act
                    let editStatus = accountDetailManager.editAccount()
                    
                    //Assert
                    expect(editStatus.0) == false
                    
                }
            }
        }
    }
}
