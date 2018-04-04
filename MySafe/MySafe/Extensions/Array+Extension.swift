//
//  Array+Extension.swift
//  MySafe
//
//  Created by Luiz Felipe Albernaz Pio on 03/04/18.
//  Copyright © 2018 Luiz Felipe Albernaz Pio. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    mutating func removeElement(_ element: Element) -> Element? {
        
        guard let index = self.index(of: element) else { return nil }
        
        return remove(at: index)
    }
}
