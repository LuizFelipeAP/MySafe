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

    var account = BehaviorRelay<Account?>(value: nil)
    lazy var accountObservable = self.account.asObservable()

    init(account: Account) {
        self.account.accept(account)
    }
    
    func removeAccount() -> Bool {
        guard let account = self.account.value else { return false }
        return KeychainPersistence.shared.remove(account: account)
    }
}

