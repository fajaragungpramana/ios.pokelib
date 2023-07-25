//
//  DatabaseManager.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import SQLite

class DatabaseManager {
    
    private static var TABLE_NAME = "favorite_pokemons.sqlite3"
    
    private var mDb: Connection!
    private var mFavoritePokemonTable: Table!
    private var mFavoritePokemonSchema: FavoritePokemonSchema!
    
    init() {
        do {
            
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            self.mDb = try Connection("\(path)/\(DatabaseManager.TABLE_NAME)")
            self.mFavoritePokemonTable = Table("pokemons")
            
            self.mFavoritePokemonSchema = FavoritePokemonSchema(
                id: Expression<Double>("id"),
                name: Expression<String>("name"),
                image: Expression<String>("image"),
                about: Expression<String>("about"),
                height: Expression<Int>("height"),
                weight: Expression<Int>("weight")
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
        } catch {
            print("DatabaseManager.setFavoritePokemon : " + error.localizedDescription)
            
            return false
        }
        
        return true
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
                    weight: pokemon[self.mFavoritePokemonSchema.weight]
                ))
            }
            
        } catch {
            print("DatabaseManager.getFavoritePokemon : " + error.localizedDescription)
        }
        
        return listFavoritePokemonEntity
    }
    
    func deleteFavoritePokemon(id: Double) throws -> Bool {
        let pokemon = self.mFavoritePokemonTable.filter(self.mFavoritePokemonSchema.id == id)
        do {
            return try self.mDb.run(pokemon.delete()) > 0
        } catch {
            print("DatabaseManager.deleteFavoritePokemon : " + error.localizedDescription)
            
            return false
        }
    }
    
}
