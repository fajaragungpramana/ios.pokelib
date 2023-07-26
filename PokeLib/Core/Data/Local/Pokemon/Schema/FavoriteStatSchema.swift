//
//  FavoriteStatEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import SQLite

struct FavoriteStatSchema {
    var id: Expression<Int64>
    var pokemonId: Expression<Double>
    var name: Expression<String>
    var value: Expression<Int>
}
