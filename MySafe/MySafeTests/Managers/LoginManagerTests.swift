//
//  LoginManagerTests.swift
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

class LoginManagerTests: QuickSpec {

    override func spec() {
        
        var loginManager: LoginManager!
        
        let username = "john@mail.com"
        let passcode = "Pass@12345"
        
        beforeEach {
            let apiService = APIServiceMock()
            let persistenceService = KeychainPersistenceMock()
            loginManager = LoginManager(apiService: apiService, persistenceService: persistenceService)
        }
        
        describe("testing Login manager") {
            
            context("build user") {
                
                it("should succeed") {
                    
                    //Arrange
                    loginManager.username.accept(username)
                    loginManager.passcode.accept(passcode)
                    
                    //Act
                    loginManager.buildUser()
                    
                    //Assert
                    expect(loginManager.user.username).to(equal(username))
                    expect(loginManager.user.passcode).to(equal(passcode))
                    
                }
                
            }
            
            context("validate credentials") {
                
                it("should succeed") {
                    
                    //Arrange
                    let user = User(username: username, passcode: passcode)
                    
                    loginManager.user = user
                    
                    //Act
                    let isValid = loginManager.isValidLogin()
                    
                    //Assert
                    expect(isValid) == true
                }
                
                it("should fail") {
                    
                    //Arrange
                    let user = User(username: "J", passcode: "1")
                    
                    loginManager.user = user
                    
                    //Act
                    let isValid = loginManager.isValidLogin()
                    
                    //Assert
                    expect(isValid) == false
                }
            }
            
            context("authetication") {
                
                it("should authenticate with success") {
                    
                    //Arrange
                    loginManager.username.accept("tom@mail.com")
                    loginManager.passcode.accept(passcode)
                    
                    //Act & Asser
                   
                    waitUntil(timeout: 2) { done in
                        
                        loginManager.authenticateUser(completion: { (success, msg) -> (Void) in
                            
                            expect(success) == false
                            
                            done()
                        })
                    }
                }
                
                it("should fail at authentication") {
                    
                }
            }
        }
    }
    
}
