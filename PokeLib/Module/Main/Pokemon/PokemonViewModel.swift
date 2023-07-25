//
//  PokemonViewModel.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 20/07/23.
//

import Foundation
import RxSwift

class PokemonViewModel : ObservableObject {
    
    @Inject private var mPokemonUseCase: PokemonUseCase
    @Inject private var mDisposeBag: DisposeBag
    
    @Published private var _isLoadingPokemon: Bool = false
    var isLoadingPokemon: Bool {
        get {
            return _isLoadingPokemon
        }
    }
    
    @Published private var _listPokemon: [Pokemon] = []
    var listPokemon: [Pokemon] {
        get {
            return _listPokemon
        }
    }
    
    init() {
        getListPokemon()
    }
    
    private func getListPokemon() {
        _isLoadingPokemon = true
        mPokemonUseCase.getListPokemon(request: PokemonRequest())
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { listPokemon in
                    self._isLoadingPokemon = false
                    self._listPokemon = listPokemon
                },
                onError: { error in
                    self._isLoadingPokemon = false
                }
            ).disposed(by: mDisposeBag)
    }
    
}
