//
//  FavoritePokemonRepository.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import RxSwift

protocol FavoritePokemonRepository {
    func setPokemonFavorite(request: FavoritePokemonRequest) -> Observable<Bool>
    func isPokemonFavorite(id: Double) -> Observable<Bool>
    func deletePokemonFavorite(id: Double) -> Observable<Bool>
}
