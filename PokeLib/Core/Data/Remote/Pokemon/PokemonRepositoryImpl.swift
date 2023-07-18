//
//  PokemonRepositoryImpl.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import RxSwift
import RxCocoa

class PokemonRepositoryImpl : PokemonRepository {

    private let mPokemonService: PokemonService
    private let mDisposeBag: DisposeBag
    
    init(pokemonService: PokemonService, disposeBag: DisposeBag) {
        self.mPokemonService = pokemonService
        self.mDisposeBag = disposeBag
    }
    
    func getListPokemon(request: PokemonRequest) -> BehaviorRelay<AppResult<[PokemonEntity]>> {
        let result = BehaviorRelay<AppResult<[PokemonEntity]>>(value: .OnLoading(true))
        
        self.mPokemonService.getListPokemon(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { listPokemonResponse in
                    var listPokemonEntity: [PokemonEntity] = []
                    
                    listPokemonResponse.results?.forEach { pokemonEntity in
                        let removeContent = pokemonEntity.url?.replacingOccurrences(
                            of: AppConfig.baseUrl.value() + HttpRouteConstant.pokemon.rawValue + "/",
                            with: ""
                        )
                        let id = removeContent?.replacingOccurrences(of: "/", with: "") ?? "0"
                        
                        self.mPokemonService.getPokemon(id: Double(id))
                            .observe(on: MainScheduler.instance)
                            .subscribe(
                                onNext: { pokemonEntity in
                                    var pokemonEntity = pokemonEntity
                                    pokemonEntity.id = Double(id)
                                    
                                    listPokemonEntity.append(pokemonEntity)
                                }
                            ).disposed(by: self.mDisposeBag)
                    }
                    
                    result.accept(AppResult.OnLoading(false))
                    result.accept(AppResult.OnSuccess(listPokemonEntity))
                },
                onError: { error in
                    result.accept(AppResult.OnLoading(false))
                    result.accept(AppResult.OnFailure(error))
                }
            ).disposed(by: self.mDisposeBag)
        
        return result
    }
    
}
