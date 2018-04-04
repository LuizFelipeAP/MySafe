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

class LoginManager {
    
    //MARK: Properties
    var user: User!
    
    var username = BehaviorRelay<String>(value: "")
    var passcode = BehaviorRelay<String>(value: "")
    
    let disposeBag = DisposeBag()
    
    //MARK: - Methods
    func authenticateUser(completion: @escaping (Bool, String) -> ()) {
        
        self.buildUser()
        
        if self.isValidLogin() {
            
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
                    
                } else {
                    
                    if let apiMessage = apiResponse?.message {
                        message = apiMessage
                    } else {
                        message = "Server Error"
                    }
                }
                
                completion(isSuccess, message)
            }
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
