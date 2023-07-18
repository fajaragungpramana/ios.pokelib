//
//  PokemonRequestEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

struct PokemonRequest {
    var limit: Int = 25
    var offset: Int = 1
    
    func create() -> [String: Any] {
        return [
            HttpParamConstant.limit.rawValue : limit,
            HttpParamConstant.offset.rawValue : offset
        ]
    }
}
