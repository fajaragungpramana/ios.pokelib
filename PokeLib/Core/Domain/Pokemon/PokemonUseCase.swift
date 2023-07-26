//
//  PokemonUseCase.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import RxSwift

protocol PokemonUseCase {
    func getListPokemon(request: PokemonRequest) -> Observable<[Pokemon]>
    func getPokemonSpecies(id: Double?) -> Observable<PokemonSpecies>
    func setFavoritePokemon(request: FavoritePokemonRequest) -> Observable<Bool>
    func isFavoritePokemon(id: Double) -> Observable<Bool>
    func getListFavoritePokemon() -> Observable<[Pokemon]>
    func deleteFavoritePokemon(id: Double) -> Observable<Bool>
}
