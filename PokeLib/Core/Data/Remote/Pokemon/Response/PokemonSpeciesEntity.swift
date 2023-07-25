//
//  PokemonSpeciesEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 24/07/23.
//

struct PokemonSpeciesEntity : Codable {
    var flavorTextEntries: [FlavorTextEntity]?
    
    private enum CodingKeys : String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        
        flavorTextEntries = try? value.decode([FlavorTextEntity].self, forKey: .flavorTextEntries)
    }
    
}
