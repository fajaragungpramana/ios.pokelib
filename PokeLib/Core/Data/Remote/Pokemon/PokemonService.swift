//
//  PokemonService.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 03/07/23.
//

import Alamofire

enum PokemonService : URLRequestConvertible {
    case getListPokemon(params: Parameters)
    
    var method: HTTPMethod {
        switch self {
        case .getListPokemon:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getListPokemon:
            return "pokemon"
        }
    }
    
    var parameter: Parameters {
        switch self {
        case .getListPokemon(let params):
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try AppClient.shared.urlRequest(
            method: method,
            path: path,
            parameters: parameter
        )
    }
    
}
