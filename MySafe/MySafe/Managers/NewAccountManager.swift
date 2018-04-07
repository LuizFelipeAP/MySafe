//
//  NewAccountManager.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NewAccountManager {
 
    //MARK: - Properties
    var account: Account!
    
    var application = BehaviorRelay<String>(value: "")
    var username = BehaviorRelay<String>(value: "")
    var passcode = BehaviorRelay<String>(value: "")
    
    let disposeBag = DisposeBag()
    
    //MARK: Services
    var persistenceService: PersistenceProtocol
    
    //MARK: Inits
    init(persistenceService: PersistenceProtocol) {
        self.persistenceService = persistenceService
    }
    
    //MARK: - Methods
    
    /**
     Save an new account to Keychain
     
     - returns:
     True if the account was successfully saved or false if it's not
     
     */
    func saveAccount() -> (Bool, String) {
        
        let status: (Bool, String)
        
        self.buildAccount()
        
        if self.isValidAccount() {
            
            if self.persistenceService.add(account: self.account) {
                status = (true, "New account successfully saved")
            } else {
                status = (false, "Sorry couldn't save the account")
            }
            
        } else {
            status = (false, "PLEASE PUT AT LEAST 3 CHARACTERS IN EACH FIELD")
        }
        
        return status
    }
    
    func isValidAccount() -> Bool {
        
        let validApplication = ValidationUtil.shared.isValid(name: self.account.application)
        
        let validUsername = ValidationUtil.shared.isValid(name: self.account.username)
        
        let validPasscode = ValidationUtil.shared.isValid(name: self.account.passcode)
        
        return validApplication && validUsername && validPasscode
    }
    
    func buildAccount() {
        
        let application = self.application.value
        let username = self.username.value
        let passcode = self.passcode.value
        
        let account = Account(application: application,
                              username: username,
                              passcode: passcode)
        
        self.account = account
    }
}
