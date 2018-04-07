//
//  AccountDetailManager.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 04/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AccountDetailManager {

    var originalAccount = BehaviorRelay<Account?>(value: nil)
    lazy var accountObservable = self.originalAccount.asObservable()

    var edditedAccount: Account? = nil {
        didSet {
            guard let oAccount = self.originalAccount.value else { return }
            self.edditedAccount?.id = oAccount.id
        }
    }

    //MARK: Services
    var persistenceService: PersistenceProtocol
    
    //MARK: - Inits
    init(account: Account, persistenceService: PersistenceProtocol) {
        self.originalAccount.accept(account)
        self.persistenceService = persistenceService
    }
    
    //MARK: - Methods
    
    func removeAccount() -> Bool {
        guard let account = self.originalAccount.value else { return false }
        return self.persistenceService.remove(account: account)
    }
    
    func isAccountEddited() -> Bool {
        
        guard let originalAccount = self.originalAccount.value,
            let changedAccount = self.edditedAccount else { return false }
        
        return !originalAccount.veryEqual(to: changedAccount)
    }
    
    func editAccount() -> (Bool, String) {
        
        let status: (Bool, String)
        
        guard let accountToEdit = self.edditedAccount else { return (false, "Something goes terribly wrong") }
        
        if self.isValidAccount() {
            
            if self.persistenceService.update(account: accountToEdit) {
                status = (true, "Account successfully updated")
            } else {
                status = (false, "Sorry couldn't update the account")
            }
            
        } else {
            status = (false, "PLEASE PUT AT LEAST 3 CHARACTERS IN EACH FIELD")
        }
        
        return status
    }
    
    func isValidAccount() -> Bool {
        
        guard let edditedAccount = self.edditedAccount else { return false }
        
        let validApplication = ValidationUtil.shared.isValid(name: edditedAccount.application)
        
        let validUsername = ValidationUtil.shared.isValid(name: edditedAccount.username)
        
        let validPasscode = ValidationUtil.shared.isValid(name: edditedAccount.passcode)
        
        return validApplication && validUsername && validPasscode
    }
}

