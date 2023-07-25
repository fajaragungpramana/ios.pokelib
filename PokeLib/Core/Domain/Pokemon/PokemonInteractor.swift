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
    
    func getListPokemon(request: PokemonRequest) -> Observable<[Pokemon]> {
        return Observable<[Pokemon]>.create { observer in
            let task = Task {
                self.mPokemonRepository.getListPokemon(request: request)
                    .observe(on: MainScheduler.instance)
                    .subscribe(
                        onNext: { listPokemonEntity in
                            observer.on(.next(Pokemon.mapToList(data: listPokemonEntity)))
                            observer.on(.completed)
                        },
                        onError: { error in
                            observer.on(.error(error))
                        }
                    ).disposed(by: self.mDisposeBag)
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func getPokemonSpecies(id: Double?) -> Observable<PokemonSpecies> {
        return Observable<PokemonSpecies>.create { observer in
            let task = Task {
                self.mPokemonRepository.getPokemonSpecies(id: id)
                    .observe(on: MainScheduler.instance)
                    .subscribe(
                        onNext: { listPokemonSpecies in
                            observer.on(.next(PokemonSpecies.mapToObject(data: listPokemonSpecies)))
                            observer.on(.completed)
                        },
                        onError: { error in
                            observer.on(.error(error))
                        }
                    )
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}
