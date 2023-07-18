//
//  PokemonRoute.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import Alamofire

enum PokemonRoute : URLRequestConvertible {
    case getListPokemon(Parameters)
    case getPokemon(Double?)
    
    var method: HTTPMethod {
        switch self {
        case .getListPokemon, .getPokemon:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getListPokemon:
            return HttpRouteConstant.pokemon.rawValue
        case .getPokemon(let id):
            return HttpRouteConstant.pokemon.rawValue + "/" + String(format: "%.0f", id ?? 0)
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getListPokemon(let parameters):
            return parameters
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try AppRoute.shared.urlRequest(
            method: method,
            path: path,
            parameters: parameter
        )
    }
    
}
