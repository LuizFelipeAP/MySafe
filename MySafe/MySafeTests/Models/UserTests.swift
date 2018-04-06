//
//  UserTests.swift
//  MySafeTests
//
//  Created by Luiz Felipe Albernaz Pio on 06/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Quick
import Nimble

@testable import MySafe

class UserTests: QuickSpec {
    
    override func spec() {
    
        var commonUser: User!
        
        beforeEach {
            commonUser = User(name: "Mark Wahlberg",
                              username: "markw",
                              passcode: "**********")
        }
        
        describe("testing User model") {
            
            context("equality") {
                
                it("should match") {

                    //Arrange specific User
                    let matchingUser: User = User(name: "Mark Wahlberg",
                                                  username: "markw",
                                                  passcode: "**********")
                    
                    //Act
                    let isEqual: Bool = commonUser! == matchingUser
                    
                    //Assert
                    expect(isEqual) == true
                }
                
                it("should not match") {
                    
                    //Arrange specific non matching user
                    let notMatchingUser: User = User(name: "Mark Wahlberg",
                                                      username: "MW",
                                                      passcode: "**********")
                    
                    let isEqual: Bool = commonUser == notMatchingUser
                    
                    expect(isEqual) == false
                }
            }
        }
    }
}
