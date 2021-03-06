//
//  SignupManager.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SignupManager {
    
    //MARK: - Properties
    var user: User!
    
    var name = BehaviorRelay<String>(value: "")
    var username = BehaviorRelay<String>(value: "")
    var passcode = BehaviorRelay<String>(value: "")
    
    let disposeBag = DisposeBag()
    
    //MARK: Services
    var apiService: APIServiceProtocol
    var persistenceService: PersistenceProtocol
    
    //MARK: Inits
    init(apiService: APIServiceProtocol,
         persistenceService: PersistenceProtocol) {
        self.apiService = apiService
        self.persistenceService = persistenceService
    }
    
    //MARK: - Methods
    func registerUser(completion: @escaping (Bool, String) -> ()) {
        
        self.buildUser()
        
        if self.isValidFields() {
         
            self.apiService.postNew(user: self.user) { (apiResponse) -> (Void) in
                
                //Save the token to UserSession
                
                let isSuccess = apiResponse?.success == true
                let message: String
                
                if isSuccess {
                    message = "Success"
                    
                    if let token = apiResponse?.token {
                        UserSession.shared.user = self.user
                        UserSession.shared.token = token
                    }
                    
                    self.persistenceService.add(user: self.user)
                    
                } else {
                    if let responseMessage = apiResponse?.message {
                        message = responseMessage
                    } else {
                        message = "Server error"
                    }
                }
                
                completion(isSuccess, message)
            }
        } else {
            completion(false, "Invalid e-mail or passcode")
        }
    }
    
    func isValidFields() -> Bool {
        
        let validName = ValidationUtil.shared.isValid(name: self.user.name)
        
        let validEmail = ValidationUtil.shared.isValid(email: self.user.username)
        
        let validPass = ValidationUtil.shared.isValid(passcode: self.user.passcode)
        
        return validEmail && validPass && validName
    }
    
    func buildUser() {
        
        let name = self.name.value
        let username = self.username.value
        let passcode = self.passcode.value
        
        let user = User(name: name, username: username, passcode: passcode)
        
        self.user = user
    }
}



