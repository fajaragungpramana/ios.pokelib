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
    case getPokemonSpecies(Double?)
    
    var method: HTTPMethod {
        switch self {
        case .getListPokemon, .getPokemon, .getPokemonSpecies:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getListPokemon:
            return HttpRouteConstant.pokemon.rawValue
        case .getPokemon(let id):
            return HttpRouteConstant.pokemon.rawValue + "/" + id.roundAsString
        case .getPokemonSpecies(let id):
            return HttpRouteConstant.pokemonSpecies.rawValue + "/" + id.roundAsString
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
