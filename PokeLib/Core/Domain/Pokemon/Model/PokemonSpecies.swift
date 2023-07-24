//
//  PokemonSpecies.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 24/07/23.
//

struct PokemonSpecies {
    var about: String
    
    static func mapToObject(data: PokemonSpeciesEntity?) -> PokemonSpecies {
        guard let flavorTextEntries = data?.flavorTextEntries else {
            return PokemonSpecies(
                about: ""
            )
        }
        
        return PokemonSpecies(
            about: flavorTextEntries[0].flavorText.onEmpty
        )
    }
}
