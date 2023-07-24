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
    
    func getListPokemon(request: PokemonRequest) -> Observable<[PokemonEntity]> {
        return Observable<[PokemonEntity]>.create { observer in
            let task = Task {
                self.mPokemonService.getListPokemon(request: request)
                    .observe(on: MainScheduler.instance)
                    .subscribe(
                        onNext: { listPokemonResponse in
                            let dispatchGroup = DispatchGroup()
                            var listPokemonEntity: [PokemonEntity] = []
                            
                            listPokemonResponse.results?.forEach { pokemonEntity in
                                dispatchGroup.enter()
                                
                                let urlPath = AppRoute.shared.baseUrl + HttpRouteConstant.pokemon.rawValue + "/"
                                let id = pokemonEntity.url?
                                    .replacingOccurrences(of: urlPath, with: "")
                                    .replacingOccurrences(of: "/", with: "")
                                    .toDouble
                                
                                self.mPokemonService.getPokemon(id: id)
                                    .observe(on: MainScheduler.instance)
                                    .subscribe(
                                        onNext: { pokemonEntity in
                                            var pokemonEntity = pokemonEntity
                                            pokemonEntity.id = id
                                
                                            listPokemonEntity.append(pokemonEntity)
                                            
                                            dispatchGroup.leave()
                                        }
                                    ).disposed(by: self.mDisposeBag)
                            }
                            
                            dispatchGroup.notify(queue: .main) {
                                observer.on(.next(listPokemonEntity))
                                observer.on(.completed)
                            }
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
    
    func getPokemonSpecies(id: Double?) -> Observable<PokemonSpeciesEntity> {
        return mPokemonService.getPokemonSpecies(id: id)
    }
    
}
