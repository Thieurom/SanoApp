//
//  Array+Extensions.swift
//  Sano
//
//  Created by Doan Le Thieu on 8/17/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    func allEqualTo(_ value: Element) -> Bool {
        guard !self.isEmpty else {
            return false
        }
        
        return !contains { $0 != value }
    }
}
