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
        return username.value == "John" && passcode.value == "Pass@#3456"
    }
    
}
