//
//  DoubleExtension.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 21/07/23.
//

extension Double? {
    
    var onEmpty: Double {
        guard let value = self else {
            return 0
        }
        
        return value
    }
    
    var roundAsString: String {
        guard let value = self else {
            return "0"
        }
        
        return String(format: "%.0f", value)
    }
    
}
