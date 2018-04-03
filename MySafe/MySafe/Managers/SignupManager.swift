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
    
    //MARK: - Methods
    func registerUser(completion: @escaping (Bool, String) -> ()) {
        
        self.buildUser()
        
        if self.isValidFields() {
         
            APIService.shared.postNew(user: self.user) { (apiResponse) -> (Void) in
                
                //Save the token to UserSession
                
                let isSuccess = apiResponse?.success == true
                let message: String
                
                if isSuccess {
                    message = "Success"
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
            completion(false, "Invalid Credentials")
        }
    }
    
    func isValidFields() -> Bool {
        
        let validName = ValidationUtil.shared.isValid(name: self.user.name)
        
        let validEmail = ValidationUtil.shared.isValid(email: self.user.username)
        
        let validPass = ValidationUtil.shared.isValid(passcode: self.user.passcode)
        
        return validEmail && validPass && validName
    }
    
    func buildUser() {
        
        let username = self.username.value
        let passcode = self.passcode.value
        
        let user = User(username: username, passcode: passcode)
        
        self.user = user
    }
}



