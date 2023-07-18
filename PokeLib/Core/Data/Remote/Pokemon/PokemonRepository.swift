//
//  PokemonRepository.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import RxCocoa

protocol PokemonRepository {
    func getListPokemon(request: PokemonRequest) -> BehaviorRelay<AppResult<[PokemonEntity]>>
}
