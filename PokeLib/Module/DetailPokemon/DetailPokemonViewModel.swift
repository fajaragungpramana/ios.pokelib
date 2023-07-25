//
//  DetailPokemonViewModel.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 24/07/23.
//

import Foundation
import RxSwift

class DetailPokemonViewModel : ObservableObject {
    
    @Inject private var mPokemonUseCase: PokemonUseCase
    @Inject private var mDisposeBag: DisposeBag
    
    @Published private var _isLoadingPokemonSpecies: Bool = false
    var isLoadingPokemonSpecies: Bool {
        get {
            return _isLoadingPokemonSpecies
        }
    }
    
    @Published private var _pokemonSpecies: PokemonSpecies = PokemonSpecies(
        about: ""
    )
    var pokemonSpecies: PokemonSpecies {
        get {
            return _pokemonSpecies
        }
    }
    
    func getPokemonSpecies(id: Double) {
        _isLoadingPokemonSpecies = true
        mPokemonUseCase.getPokemonSpecies(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { pokemonSpecies in
                    self._isLoadingPokemonSpecies = false
                    self._pokemonSpecies = pokemonSpecies
                },
                onError: { error in
                    self._isLoadingPokemonSpecies = false
                }
            )
            .disposed(by: mDisposeBag)
            
    }
    
}
