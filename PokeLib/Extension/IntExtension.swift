//
//  IntExtension.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 21/07/23.
//

extension Int? {
    
    func onNull() -> Int {
        guard let value = self else {
            return 0
        }
        
        return value
    }
    
}
