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
    
}

extension String {
    
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        
        return firstLetter + remainingLetters
    }
    
}
