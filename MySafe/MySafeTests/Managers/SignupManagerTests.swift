//
//  SignupManagerTests.swift
//  MySafeTests
//
//  Created by Luiz Felipe Albernaz Pio on 06/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Quick
import Nimble

@testable import MySafe

class SignupManagerTests: QuickSpec {

    override func spec() {
        
        var signupManager: SignupManager!
        
        let name = "John"
        let username = "john@mail.com"
        let passcode = "Pass@12345"
        
        beforeEach {
            let apiService = APIServiceMock()
            let persistenceService = KeychainPersistenceMock()
            signupManager = SignupManager(apiService: apiService, persistenceService: persistenceService)
        }
        
        describe("testing signup manager") {
            
            context("build user") {
                
                it("should succeed") {
                    
                    //Arrange
                    signupManager.name.accept(name)
                    signupManager.username.accept(username)
                    signupManager.passcode.accept(passcode)
                    
                    //Act
                    signupManager.buildUser()
                    
                    //Assert
                    expect(signupManager.user.name).to(equal(name))
                    expect(signupManager.user.username).to(equal(username))
                    expect(signupManager.user.passcode).to(equal(passcode))
                    
                }
                
            }
            
            context("validate fields") {
                
                it("should succeed") {
                    
                    //Arrange
                    let user = User(name: name, username: username, passcode: passcode)
                    
                    signupManager.user = user
                    
                    //Act
                    let isValid = signupManager.isValidFields()
                    
                    //Assert
                    expect(isValid) == true
                }
                
                it("should fail") {
                    
                    //Arrange
                    let user = User(name: "Be", username: "J", passcode: "1")
                    
                    signupManager.user = user
                    
                    //Act
                    let isValid = signupManager.isValidFields()
                    
                    //Assert
                    expect(isValid) == false
                }
            }
            
            context("register new user") {
                
                it("should success") {
                    
                    //Arrange
                    signupManager.name.accept("Terry")
                    signupManager.username.accept("crews@mail.com")
                    signupManager.passcode.accept(passcode)
                    
                    //Act & Assert
                    
                    waitUntil(timeout: 2) { done in
                        
                        signupManager.registerUser(completion: { (success, msg) in
                            
                            expect(success) == true
                            expect(msg) == "Success"
                            
                            done()
                        })
                    }
                }
                
                //Should fail because it's already registred
                it("should fail") {
                    //Arrange
                    signupManager.name.accept(name)
                    signupManager.username.accept(username)
                    signupManager.passcode.accept("Hardcore!@123")
                    
                    //Act & Assert
                    
                    waitUntil(timeout: 2) { done in
                        
                        signupManager.registerUser(completion: { (success, msg) in
                            
                            expect(success) == false
                            expect(msg) == "Duplicate key for property email"
                            
                            done()
                        })
                    }
                }
            }
        }
    }
    
}
