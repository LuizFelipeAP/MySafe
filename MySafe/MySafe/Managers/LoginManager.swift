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
    
    var username = BehaviorRelay(value: "")
    var passcode = BehaviorRelay(value: "")
    
    let disposeBag = DisposeBag()
    
    //MARK: - Methods
    func authenticateUser(completion: @escaping (Bool, String) -> ()) {
        
        if self.isValidLogin() {
        
            self.buildUser()
            
            APIService.shared.authenticate(user: self.user) { (apiResponse) -> (Void) in
                
                //Save the token to UserSession
                
                let isSuccess = apiResponse?.success == true
                let message: String
                
                if isSuccess {
                    message = "Success"
                } else {
                    message = "Server Error"
                }
                
                completion(isSuccess, message)
            }
        } else {
            completion(false, "Invalid Credentials")
        }
    }
    
    func isValidLogin() -> Bool {
        
        let validEmail = ValidationUtil.shared.isValid(email: self.username.value)
        
        let validPass = ValidationUtil.shared.isValid(passcode: self.passcode.value)
        
        return validEmail && validPass
    }
    
    func buildUser() {
        
        let username = self.username.value
        let passcode = self.passcode.value
        
        let user = User(username: username, passcode: passcode)
        
        self.user = user
    }
}

