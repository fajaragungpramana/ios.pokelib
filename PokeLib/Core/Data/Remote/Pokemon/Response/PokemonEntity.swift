//
//  PokemonEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

struct PokemonEntity : Codable {
    var id: Double?
    var name: String?
    var url: String?
    var sprites: SpriteEntity?
    var stats: [StatEntity]?
    var height: Int?
    var weight: Int?
    
    private enum CodingKeys : String, CodingKey {
        case id
        case name
        case url
        case sprites
        case stats
        case height
        case weight
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? values.decode(Double.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
        url = try? values.decode(String.self, forKey: .url)
        sprites = try? values.decode(SpriteEntity.self, forKey: .sprites)
        stats = try? values.decode([StatEntity].self, forKey: .stats)
        height = try? values.decode(Int.self, forKey: .height)
        weight = try? values.decode(Int.self, forKey: .weight)
    }
}
