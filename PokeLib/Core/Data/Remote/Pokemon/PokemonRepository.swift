//
//  PokemonRepository.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import RxSwift

protocol PokemonRepository {
    func getListPokemon(request: PokemonRequest) -> Observable<[PokemonEntity]>
}
