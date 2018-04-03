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
        if isValid(passcode: self.passcode.value) {
            return username.value == "John"
        } else {
            print("Not valid")
            return false
        }
    }
}

//**************************************************************************************
//
// MARK: - Validations Extension
//
//**************************************************************************************
extension LoginManager {
    
    func isValid(userName: String) -> Bool {
        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        let isMinimumLenght = trimmedUserName.count > 3
        
        return isMinimumLenght
    }
    
    func isValid(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return RegexUtil.shared.evaluate(email, matchesWith: regex)
    }
    
    func isValid(passcode: String) -> Bool {
        
        if passcode.count < 8 {
            return false
        }
        
        //Contains a lowercase
        let lowerRegex = ".*[a-z].*"
        if !RegexUtil.shared.evaluate(passcode, matchesWith: lowerRegex) {
            return false
        }

        //Contains an uppercase
        let upperRegex = ".*[A-Z].*"
        if !RegexUtil.shared.evaluate(passcode, matchesWith: upperRegex) {
            return false
        }
        
        //Contains number
        let numberRegex = ".*[0-9].*"
        if !RegexUtil.shared.evaluate(passcode, matchesWith: numberRegex) {
            return false
        }
        
        //Contains special char
        let specialRegex = ".*[!&^%$#@()/_*+-]+.*"
        if !RegexUtil.shared.evaluate(passcode, matchesWith: specialRegex) {
            return false
        }
        
        return true
    }
}
