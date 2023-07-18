//
//  Pokemon.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

struct Pokemon {
    var id: Double?
    var name: String?
    var image: String?
    var about: String?
    var height: Int?
    var weight: Int?
    var listStat: [Stat]?
    
    static func mapToList(data: [PokemonEntity]?) -> [Pokemon] {
        var listPokemon: [Pokemon] = []
        
        guard let data = data else {
            return []
        }
        for i in 0...data.count - 1 {
            
            if let listStatEntity = data[i].stats {
                var listStat: [Stat] = []
                for j in 0...listStatEntity.count - 1 {
                    listStat.append(
                        Stat(
                            value: listStatEntity[j].baseStat,
                            name: listStatEntity[j].stat?.name
                        )
                    )
                }
                listPokemon.append(
                    Pokemon(
                        id: data[i].id,
                        name: data[i].name,
                        image: data[i].sprites?.other?.officialArtwork?.frontDefault,
                        about: nil,
                        height: data[i].height,
                        weight: data[i].weight,
                        listStat: listStat
                    )
                )
            } else {
                listPokemon.append(
                    Pokemon(
                        id: data[i].id,
                        name: data[i].name,
                        image: data[i].sprites?.other?.officialArtwork?.frontDefault,
                        about: nil,
                        height: data[i].height,
                        weight: data[i].weight,
                        listStat: nil
                    )
                )
            }
            
        }
        
        return listPokemon
    }
}
