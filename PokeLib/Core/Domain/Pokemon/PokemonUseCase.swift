//
//  PokemonUseCase.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import RxSwift

protocol PokemonUseCase {
    func getListPokemon(request: PokemonRequest) -> Observable<[Pokemon]>
}
