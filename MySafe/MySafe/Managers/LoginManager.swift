//
//  LoginManager.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import LocalAuthentication

class LoginManager {
    
    //MARK: Properties
    var user: User!
    
    var username = BehaviorRelay<String>(value: "")
    var passcode = BehaviorRelay<String>(value: "")
    
    let disposeBag = DisposeBag()
    
    var authenticatedUsers: [User] = []
    
    var canEnableTouchID: PublishSubject<Bool>!
    
    lazy var deviceSupportTouchID: Bool = {
        
        let context =  LAContext()
        var error: NSError?
    
        return context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }()
    
    //MARK: - Methods
    init() {
        self.initObservables()
    }
    
    func loadAuthenticatedUsers() {
        self.authenticatedUsers = KeychainPersistence.shared.getAllUsers()
    }
    
    func initObservables() {
        
        self.canEnableTouchID = PublishSubject<Bool>()
        
        self.username.asObservable()
            .subscribe(onNext: { username in
                let contains = self.authenticatedUsers.contains(where: { user -> Bool in
                    return user.username == username
                })
                self.canEnableTouchID.onNext(contains)
            })
            .disposed(by: self.disposeBag)
    }
    
    func authenticateUser(completion: @escaping (Bool, String) -> (Void)) {
        
        self.buildUser()
        
        if self.isValidLogin() {
            
            self.authenticateWithAPI(completion: completion)
        } else {
            completion(false, "Invalid e-mail or passcode")
        }
    }
    
    func isValidLogin() -> Bool {
        
        let validEmail = ValidationUtil.shared.isValid(email: self.user.username)
        
        let validPass = ValidationUtil.shared.isValid(passcode: self.user.passcode)
        
        return validEmail && validPass
    }
    
    func buildUser() {
        
        let username = self.username.value
        let passcode = self.passcode.value
        
        let user = User(username: username, passcode: passcode)
        
        self.user = user
    }
}

//**************************************************************************************
//
// MARK: - API Related Extension
//
//**************************************************************************************
extension LoginManager {
    
    func authenticateWithAPI(completion: @escaping (Bool, String) -> (Void) ) {
        APIService.shared.authenticate(user: self.user) { (apiResponse) -> (Void) in
            
            //Save the token to UserSession
            
            let isSuccess = apiResponse?.success == true
            let message: String
            
            if isSuccess {
                message = "Success"
                
                if let token = apiResponse?.token {
                    UserSession.shared.user = self.user
                    UserSession.shared.token = token
                }
                
                KeychainPersistence.shared.add(user: self.user)
                
            } else {
                
                if let apiMessage = apiResponse?.message {
                    message = apiMessage
                } else {
                    message = "Server Error"
                }
            }
            
            completion(isSuccess, message)
        }
    }
}

//**************************************************************************************
//
// MARK: - TouchID Related Extension
//
//**************************************************************************************
extension LoginManager {
    
    func authenticateWithTouchID(completion: @escaping (Bool, String?) -> (Void)) {
        
        let context =  LAContext()
        
        if self.deviceSupportTouchID {
            
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "You can login with your TouchID") { (success, error) in
                
                if success {
                    
                    guard let index = self.authenticatedUsers.index(where:  {
                        $0.username == self.username.value
                    }) else {
                        completion(false, "")
                        return
                    }
                    
                    self.user = self.authenticatedUsers[index]
                    
                    self.authenticateWithAPI(completion: completion)
                }
            }
        }
    }
}
