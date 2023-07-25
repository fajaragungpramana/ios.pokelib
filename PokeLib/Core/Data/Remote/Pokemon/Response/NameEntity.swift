//
//  NameEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

struct NameEntity : Codable {
    var name: String?
    
    private enum CodingKeys : String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try? values.decode(String.self, forKey: .name)
    }
    
    func onMapStat() -> String {
        switch name {
        case "hp":
            return "HP"
        case "attack":
            return "ATT"
        case "defense":
            return "DEF"
        case "special-attack":
            return "S-ATT"
        case "special-defense":
            return "S-DEF"
        case "speed":
            return "SDP"
        default:
            return "-"
        }
    }
}
