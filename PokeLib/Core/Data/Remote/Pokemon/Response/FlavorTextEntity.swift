//
//  FlavorTextEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 24/07/23.
//

struct FlavorTextEntity : Codable {
    var flavorText: String?
    
    private enum CodingKeys : String, CodingKey {
        case flavorText = "flavor_text"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        
        flavorText = try? value.decode(String.self, forKey: .flavorText)
    }
    
}
