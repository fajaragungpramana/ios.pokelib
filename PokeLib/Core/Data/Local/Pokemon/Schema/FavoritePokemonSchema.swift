//
//  FavoritePokemonEntity.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import SQLite

struct FavoritePokemonSchema {
    var id: Expression<Double>
    var name: Expression<String>
    var image: Expression<String>
    var about: Expression<String>
    var height: Expression<Int>
    var weight: Expression<Int>
}
