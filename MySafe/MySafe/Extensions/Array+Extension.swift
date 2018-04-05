//
//  Array+Extension.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    /**
     You can use this method when you want to retirve something from an array in a safe mode.
     
     - Usage Description:
     ````
     let names: [String] = ["Andrew", "Catherine", "Louise"]
     
     guard let name = names.get(at: 3) else { return }
     ````
     
     - parameters:
     - index: The index of the element
     
     - returns:
     The element at the specified index or nil if you pass a index out of range
     
     */
    func get(at index: Int) -> Element? {
        if case 0..<self.count = index {
            return self[index]
        }
        return nil
    }
    
}
