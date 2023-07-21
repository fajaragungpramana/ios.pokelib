//
//  IntExtension.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 21/07/23.
//

extension Int? {
    
    var onEmpty: Int {
        guard let value = self else {
            return 0
        }
        
        return value
    }
    
}
