//
//  FavoritePokemonRepositoryImpl.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import RxSwift

class FavoritePokemonRepositoryImpl : FavoritePokemonRepository {
    
    private let mDatabaseManager: DatabaseManager
    
    init(databaseManager: DatabaseManager) {
        self.mDatabaseManager = databaseManager
    }
    
    func setPokemonFavorite(request: FavoritePokemonRequest) -> Observable<Bool> {
        return Observable.create { observer in
            let task = Task {
                do {
                    let isFavorited = try self.mDatabaseManager.setFavoritePokemon(request: request)
                    observer.on(.next(isFavorited))
                    observer.on(.completed)
                } catch {
                    observer.on(.error(error))
                }
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func isPokemonFavorite(id: Double) -> Observable<Bool> {
        return Observable.create { observer in
            let task = Task {
                do {
                    let listFavoritePokemon = try self.mDatabaseManager.getFavoritePokemon(id: id)
                    
                    observer.on(.next(!listFavoritePokemon.isEmpty))
                    observer.on(.completed)
                } catch {
                    observer.on(.error(error))
                }
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}
