//
//  PokemonService.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import RxSwift

protocol PokemonService {
    func getListPokemon(request: PokemonRequest) -> Observable<AppListResponse<PokemonEntity>>
    func getPokemon(id: Double?) -> Observable<PokemonEntity>
}
