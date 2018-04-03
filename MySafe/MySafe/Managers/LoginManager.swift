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
    func authenticateUser() -> Bool {
        if self.isValidLogin() {
            return username.value == "mock@mail.com"
        } else {
            print("Not valid")
            return false
        }
    }
    
    func isValidLogin() -> Bool {
        
        let validEmail = ValidationUtil.shared.isValid(email: self.username.value)
        
        let validPass = ValidationUtil.shared.isValid(passcode: self.passcode.value)
        
        return validEmail && validPass
    }
}

