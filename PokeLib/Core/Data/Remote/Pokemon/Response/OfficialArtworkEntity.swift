//
//  OfficialArtworkEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

struct OfficialArtworkEntity : Codable {
    var frontDefault: String?
    
    private enum CodingKeys : String, CodingKey {
        case frontDefault = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        frontDefault = try? values.decode(String.self, forKey: .frontDefault)
    }
}
