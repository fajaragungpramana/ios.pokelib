//
//  Pokemon.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

struct Pokemon {
    var id: Double
    var name: String
    var image: String
    var about: String
    var height: Int
    var weight: Int
    var listStat: [Stat]
    
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
                            value: listStatEntity[j].baseStat.onEmpty,
                            name: listStatEntity[j].stat?.onMapStat() ?? ""
                        )
                    )
                }
                listPokemon.append(
                    Pokemon(
                        id: data[i].id.onEmpty,
                        name: data[i].name.onEmpty,
                        image: data[i].sprites?.other?.officialArtwork?.frontDefault ?? "",
                        about: String(localized: "something_wrong"),
                        height: data[i].height.onEmpty,
                        weight: data[i].weight.onEmpty,
                        listStat: listStat
                    )
                )
            } else {
                listPokemon.append(
                    Pokemon(
                        id: data[i].id.onEmpty,
                        name: data[i].name.onEmpty,
                        image: data[i].sprites?.other?.officialArtwork?.frontDefault ?? "",
                        about: String(localized: "something_wrong"),
                        height: data[i].height.onEmpty,
                        weight: data[i].weight.onEmpty,
                        listStat: []
                    )
                )
            }

        }
        
        return listPokemon
    }
    
    static func mapToListFavorite(data: [FavoritePokemonEntity]) -> [Pokemon] {
        var listPokemon: [Pokemon] = []
        if data.isEmpty {
            return []
        }
        
        for i in 0...data.count - 1 {
            let listFavoriteStat = data[i].listStat
            
            if listFavoriteStat.isEmpty {
                listPokemon.append(
                    Pokemon(
                        id: data[i].id,
                        name: data[i].name,
                        image: data[i].image,
                        about: data[i].about,
                        height: data[i].height,
                        weight: data[i].weight,
                        listStat: []
                    )
                )
            } else {
                var listStat: [Stat] = []
                for j in 0...listFavoriteStat.count - 1 {
                    listStat.append(
                        Stat(
                            value: listFavoriteStat[j].value,
                            name: listFavoriteStat[j].name
                        )
                    )
                }
                
                listPokemon.append(
                    Pokemon(
                        id: data[i].id,
                        name: data[i].name,
                        image: data[i].image,
                        about: data[i].about,
                        height: data[i].height,
                        weight: data[i].weight,
                        listStat: listStat
                    )
                )
            }
            
        }
        
        return listPokemon
    }
}
