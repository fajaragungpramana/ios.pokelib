//
//  PokemonRequest.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 03/07/23.
//

import Alamofire

struct PokemonRequest {
    var limit: Int = 25
    var offset: Int = 1
    
    func create() -> Parameters {
        return [
            "limit" : limit,
            "offset" : offset
        ]
    }
}
