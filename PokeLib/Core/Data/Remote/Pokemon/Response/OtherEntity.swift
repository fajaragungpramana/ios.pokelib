//
//  OtherEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

struct OtherEntity : Codable {
    var officialArtwork: OfficialArtworkEntity?
    
    private enum CodingKeys : String, CodingKey {
        case officialArtwork = "official-artwork"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        officialArtwork = try? values.decode(OfficialArtworkEntity.self, forKey: .officialArtwork)
    }
}
