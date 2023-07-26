//
//  FavoritePokemonRepository.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import RxSwift

protocol FavoritePokemonRepository {
    func setFavoritePokemon(request: FavoritePokemonRequest) -> Observable<Bool>
    func isFavoritePokemon(id: Double) -> Observable<Bool>
    func getListFavoritePokemon() -> Observable<[FavoritePokemonEntity]>
    func deleteFavoritePokemon(id: Double) -> Observable<Bool>
}
