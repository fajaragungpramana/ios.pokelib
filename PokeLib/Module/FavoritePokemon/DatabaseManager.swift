//
//  DatabaseManager.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import SQLite

class DatabaseManager {
    
    private static var DATABASE_NAME = "favorite_pokemons.sqlite3"
    
    private var mDb: Connection!
    private var mFavoritePokemonTable: Table!
    private var mFavoriteStatTable: Table!
    
    private var mFavoritePokemonSchema: FavoritePokemonSchema!
    private var mFavoriteStatSchema: FavoriteStatSchema!
    
    init() {
        do {
            
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            self.mDb = try Connection("\(path)/\(DatabaseManager.DATABASE_NAME)")
            self.mFavoritePokemonTable = Table("pokemons")
            self.mFavoriteStatTable = Table("stats")
            
            self.mFavoritePokemonSchema = FavoritePokemonSchema(
                id: Expression<Double>("id"),
                name: Expression<String>("name"),
                image: Expression<String>("image"),
                about: Expression<String>("about"),
                height: Expression<Int>("height"),
                weight: Expression<Int>("weight")
            )
            self.mFavoriteStatSchema = FavoriteStatSchema(
                id: Expression<Int64>("id"),
                pokemonId: Expression<Double>("pokemon_id"),
                name: Expression<String>("name"),
                value: Expression<Int>("value")
            )
            
            if !CacheManager.shared.isDatabaseManagerCreated {
                try mDb.run(self.mFavoritePokemonTable.create { t in
                    t.column(self.mFavoritePokemonSchema.id, primaryKey: true)
                    t.column(self.mFavoritePokemonSchema.name)
                    t.column(self.mFavoritePokemonSchema.image)
                    t.column(self.mFavoritePokemonSchema.about)
                    t.column(self.mFavoritePokemonSchema.height)
                    t.column(self.mFavoritePokemonSchema.weight)
                })
                
                try mDb.run(self.mFavoriteStatTable.create { t in
                    t.column(self.mFavoriteStatSchema.id, primaryKey: .autoincrement)
                    t.column(self.mFavoriteStatSchema.pokemonId)
                    t.column(self.mFavoriteStatSchema.name)
                    t.column(self.mFavoriteStatSchema.value)
                })
                
                CacheManager.shared.isDatabaseManagerCreated = true
            }
            
        } catch {
            print("DatabaseManager : " + error.localizedDescription)
        }
    }
    
    func setFavoritePokemon(request: FavoritePokemonRequest) throws -> Bool {
        do {
            if try !getFavoritePokemon(id: request.id).isEmpty {
                return false
            }
            
            try self.mDb.run(self.mFavoritePokemonTable.insert(
                self.mFavoritePokemonSchema.id <- request.id,
                self.mFavoritePokemonSchema.name <- request.name,
                self.mFavoritePokemonSchema.image <- request.image,
                self.mFavoritePokemonSchema.about <- request.about,
                self.mFavoritePokemonSchema.height <- request.height,
                self.mFavoritePokemonSchema.weight <- request.weight
            ))
            
            try request.listStat.forEach { stat in
                try self.mDb.run(self.mFavoriteStatTable.insert(
                    self.mFavoriteStatSchema.pokemonId <- request.id,
                    self.mFavoriteStatSchema.name <- stat.name,
                    self.mFavoriteStatSchema.value <- stat.value
                ))
            }
        } catch {
            print("DatabaseManager.setFavoritePokemon : " + error.localizedDescription)
            
            return false
        }
        
        return true
    }
    
    func getListFavoritePokemon() throws -> [FavoritePokemonEntity] {
        var listFavoritePokemonEntity: [FavoritePokemonEntity] = []
        
        do {
            
            for pokemon in try self.mDb.prepare(self.mFavoritePokemonTable) {
                var favoritePokemonEntity = FavoritePokemonEntity(
                    id: 0,
                    name: "",
                    image: "",
                    about: "",
                    height: 0,
                    weight: 0,
                    listStat: []
                )
                
                favoritePokemonEntity.id = pokemon[self.mFavoritePokemonSchema.id]
                favoritePokemonEntity.name = pokemon[self.mFavoritePokemonSchema.name]
                favoritePokemonEntity.image = pokemon[self.mFavoritePokemonSchema.image]
                favoritePokemonEntity.about = pokemon[self.mFavoritePokemonSchema.about]
                favoritePokemonEntity.height = pokemon[self.mFavoritePokemonSchema.height]
                favoritePokemonEntity.weight = pokemon[self.mFavoritePokemonSchema.weight]
                
                let queryStat = self.mFavoriteStatTable.filter(self.mFavoriteStatSchema.pokemonId == favoritePokemonEntity.id)
                
                var listFavoriteStatEntity: [FavoriteStatEntity] = []
                for stat in try self.mDb.prepare(queryStat) {
                    listFavoriteStatEntity.append(
                        FavoriteStatEntity(
                            name: stat[self.mFavoriteStatSchema.name],
                            value: stat[self.mFavoriteStatSchema.value]
                        )
                    )
                }
                
                favoritePokemonEntity.listStat = listFavoriteStatEntity
                
                listFavoritePokemonEntity.append(favoritePokemonEntity)
            }
            
        } catch {
            print("DatabaseManager.getListFavoritePokemon : " + error.localizedDescription)
        }
        
        return listFavoritePokemonEntity
    }
    
    func getFavoritePokemon(id: Double) throws -> [FavoritePokemonEntity] {
        var listFavoritePokemonEntity: [FavoritePokemonEntity] = []
        let query = self.mFavoritePokemonTable.filter(self.mFavoritePokemonSchema.id == id)
        do {
            
            for pokemon in try self.mDb.prepare(query) {
                listFavoritePokemonEntity.append(FavoritePokemonEntity(
                    id: pokemon[self.mFavoritePokemonSchema.id],
                    name: pokemon[self.mFavoritePokemonSchema.name],
                    image: pokemon[self.mFavoritePokemonSchema.image],
                    about: pokemon[self.mFavoritePokemonSchema.about],
                    height: pokemon[self.mFavoritePokemonSchema.height],
                    weight: pokemon[self.mFavoritePokemonSchema.weight],
                    listStat: []
                ))
            }
            
        } catch {
            print("DatabaseManager.getFavoritePokemon : " + error.localizedDescription)
        }
        
        return listFavoritePokemonEntity
    }
    
    func deleteFavoritePokemon(id: Double) throws -> Bool {
        let pokemon = self.mFavoritePokemonTable.filter(self.mFavoritePokemonSchema.id == id)
        let stat = self.mFavoriteStatTable.filter(self.mFavoriteStatSchema.pokemonId == id)
        do {
            let deletePokemon = try self.mDb.run(pokemon.delete())
            let deleteStat = try self.mDb.run(stat.delete())
            
            return deletePokemon > 0 && deleteStat > 0
        } catch {
            print("DatabaseManager.deleteFavoritePokemon : " + error.localizedDescription)
            
            return false
        }
    }
    
}
