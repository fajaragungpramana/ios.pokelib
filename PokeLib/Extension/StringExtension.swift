//
//  StringExtension.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 21/07/23.
//

extension String? {
    
    var onEmpty: String {
        guard let value = self else {
            return String(localized: "something_wrong")
        }
        
        return value
    }
    
    var toDouble: Double {
        guard let value = self else {
            return 0
        }
        if !value.isNumeric {
            return 0
        }
        
        return Double(value)!
    }
    
}

extension String {
    
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        
        return firstLetter + remainingLetters
    }
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    var toDouble: Double {
        if !self.isNumeric {
            return 0
        }
        
        return Double(self)!
    }
    
}
