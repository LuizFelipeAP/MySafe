//
//  AccountTests.swift
//  MySafeTests
//
//  Created by Luiz Felipe Albernaz Pio on 06/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Quick
import Nimble

@testable import MySafe

class AccountTests: QuickSpec {
    
    override func spec() {
        
        var commonAccount: Account!
        
        beforeEach {
            commonAccount = Account(application: "mysafe.com",
                                    username: "john@mail.com",
                                    passcode: "********")
            
            commonAccount.id = UUID().uuidString
        }
        
        describe("testing Account model") {
            
            context("equality") {
                
                
                it("should match") {
                    
                    //Arrange matching Account
                    let matchingAccount: Account = Account(application: "mysafe.com",
                                                         username: "john@mail.com",
                                                         passcode: "********")
                
                    matchingAccount.id = commonAccount.id
                    
                    //Act
                    let isEqual: Bool = commonAccount! == matchingAccount
                    
                    //Assert
                    expect(isEqual) == true
                }
                
                it("should not match") {
                    
                    //Arrange non matching Account
                    let nonMatchingAccount: Account = Account(application: "mysafe.com",
                                                           username: "john@mail.com",
                                                           passcode: "********")
                    
                    nonMatchingAccount.id = "Strange UUID"
                    
                    //Act
                    let isEqual: Bool = commonAccount == nonMatchingAccount
                    
                    //Assert
                    expect(isEqual) == false
                }
            }
            
            context("fields equality") {
                
                it("should match") {
                    
                    //Arrange matching Account
                    let matchingAccount: Account = Account(application: "mysafe.com",
                                                           username: "john@mail.com",
                                                           passcode: "********")
                    
                    matchingAccount.id = commonAccount.id
                    
                    //Act
                    let isEqual: Bool = commonAccount.veryEqual(to: matchingAccount)
                    
                    //Assert
                    expect(isEqual) == true
                }
                
                it("should not match") {
                    
                    //Arrange non matching Account (CHANGED THE APP NAME)
                    let nonMatchingAccount: Account = Account(application: "netflix.com",
                                                           username: "john@mail.com",
                                                           passcode: "********")
                    
                    nonMatchingAccount.id = commonAccount.id
                    
                    //Act
                    let isEqual: Bool = commonAccount.veryEqual(to: nonMatchingAccount)
                    
                    //Assert
                    expect(isEqual) == false
                }
            }
        }
    }
}
