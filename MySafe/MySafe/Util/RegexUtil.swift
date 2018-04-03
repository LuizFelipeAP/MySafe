//
//  RegexUtil.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 02/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class RegexUtil {

    static var shared: RegexUtil = {
        return RegexUtil()
    }()
    
    private init() { }
    
    func evaluate(_ value: String, matchesWith regex: String) -> Bool {
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: value)
        
        return isValid
    }
    
}
