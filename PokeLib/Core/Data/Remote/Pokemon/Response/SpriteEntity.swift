//
//  SpriteEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

struct SpriteEntity : Codable {
    var other: OtherEntity?
    
    private enum CodingKeys : String, CodingKey {
        case other
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        other = try? values.decode(OtherEntity.self, forKey: .other)
    }
}
