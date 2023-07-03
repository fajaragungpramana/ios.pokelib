//
//  StatEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 03/07/23.
//

struct StatEntity : Codable {
    var baseStat: Int?
    var stat: NameEntity?
    
    private enum CodingKeys : String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        baseStat = try? values.decode(Int.self, forKey: .baseStat)
        stat = try? values.decode(NameEntity.self, forKey: .stat)
    }
}
