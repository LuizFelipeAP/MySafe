//
//  ValidationUtil.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

class ValidationUtil {
    
    static var shared: ValidationUtil = {
        return ValidationUtil()
    }()
    
    private init() { }
    
    
    func isValid(name: String) -> Bool {
        let trimmedUserName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let isMinimumLenght = trimmedUserName.count > 2
        
        return isMinimumLenght
    }
    
    func isValid(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return RegexUtil.shared.evaluate(email, matchesWith: regex)
    }
    
    func isValid(passcode: String) -> Bool {
        
        if passcode.count < 10 {
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
