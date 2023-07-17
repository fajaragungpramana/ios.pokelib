//
//  PokemonServiceImpl.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import RxSwift

class PokemonServiceImpl : PokemonService {
    
    private let mAppService: AppService
    
    init(appService: AppService) {
        self.mAppService = appService
    }
    
    func getListPokemon(request: PokemonRequest) -> Observable<AppListResponse<PokemonEntity>> {
        return mAppService.request(PokemonRoute.getListPokemon(request.create()))
    }
    
    func getPokemon(id: Double?) -> Observable<PokemonEntity> {
        return mAppService.request(PokemonRoute.getPokemon(id))
    }
    
}
