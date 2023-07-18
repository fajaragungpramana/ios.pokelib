//
//  PokemonInteractor.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import RxCocoa
import RxSwift

class PokemonInteractor : PokemonUseCase {
    
    private let mPokemonRepository: PokemonRepository
    private let mDisposeBag: DisposeBag
    
    init(pokemonRepository: PokemonRepository, disposeBag: DisposeBag) {
        self.mPokemonRepository = pokemonRepository
        self.mDisposeBag = disposeBag
    }
    
    func getListPokemon(request: PokemonRequest) -> BehaviorRelay<AppResult<[Pokemon]>> {
        let result = BehaviorRelay<AppResult<[Pokemon]>>(value: .OnLoading(true))
        self.mPokemonRepository.getListPokemon(request: request).subscribe { event in
            let state = event.element
            switch state {
            case .OnLoading(let isLoading):
                result.accept(AppResult.OnLoading(isLoading))
            case .OnSuccess(let listPokemonEntity):
                result.accept(AppResult.OnSuccess(Pokemon.mapToList(data: listPokemonEntity)))
            case .OnFailure(let error):
                result.accept(AppResult.OnFailure(error))
            default:
                break
            }
        }
        return result
    }
    
}
