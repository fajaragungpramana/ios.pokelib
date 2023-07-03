//
//  AppResult.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 03/07/23.
//

struct AppListResponse<T : Codable> : Codable {
    var results: [T]?
    
    private enum CodingKeys : String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        results = try? values.decode([T].self, forKey: .results)
    }
    
}
