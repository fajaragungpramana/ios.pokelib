//
//  StringExtension.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 21/07/23.
//

extension String? {
    
    func onNull() -> String {
        guard let value = self else {
            return String(localized: "something_wrong")
        }
        
        return value
    }
    
}
