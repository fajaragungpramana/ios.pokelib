//
//  DoubleExtension.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 21/07/23.
//

extension Double? {
    
    func onNull() -> Double {
        guard let value = self else {
            return 0
        }
        
        return value
    }
    
}
