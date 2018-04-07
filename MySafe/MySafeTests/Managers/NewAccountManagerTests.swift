//
//  NewAccountManagerTests.swift
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

class NewAccountManagerTests: QuickSpec {
    
    override func spec() {
    
        let application = "hbo.com"
        let username = "John"
        let passcode = "Snow"
        
        var newAccountManager: NewAccountManager!
        
        beforeEach {
            let persistenceService = KeychainPersistenceMock()
            newAccountManager = NewAccountManager(persistenceService: persistenceService)
        }
        
        describe("testing new account manager") {
            
            context("build account") {
                
                it("should succeed") {
                    
                    //Arrange
                    newAccountManager.application.accept(application)
                    newAccountManager.username.accept(username)
                    newAccountManager.passcode.accept(passcode)
                    
                    //Act
                    newAccountManager.buildAccount()
                    
                    //Assert
                    expect(newAccountManager.account.application).to(equal(application))
                    expect(newAccountManager.account.username).to(equal(username))
                    expect(newAccountManager.account.passcode).to(equal(passcode))
                }
                
            }
            
            context("saving account") {
                
                it("should succed") {
                    
                    //Arrange
                    newAccountManager.application.accept(application)
                    newAccountManager.username.accept(username)
                    newAccountManager.passcode.accept(passcode)
                    
                    //Act
                    let saveStatus = newAccountManager.saveAccount()
                    
                    //Assert
                    expect(saveStatus.0) == true
                    
                }
                
                //Fail because is invalid fields
                it("should fail") {
                    
                    //Arrange
                    newAccountManager.application.accept("a")
                    newAccountManager.username.accept("b")
                    newAccountManager.passcode.accept("c")
                    
                    //Act
                    let saveStatus = newAccountManager.saveAccount()
                    
                    //Assert
                    expect(saveStatus.0) == false
                }
            }
        }
    }
}
