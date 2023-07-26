//
//  FavoritePokemonViewModel.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import Foundation
import RxSwift

class FavoritePokemonViewModel : ObservableObject {
    
    @Inject private var mPokemonUseCase: PokemonUseCase
    @Inject private var mDisposeBag: DisposeBag
    
    @Published private var _isLoadingFavoritePokemon: Bool = false
    var isLoadingFavoritePokemon: Bool {
        get {
            return _isLoadingFavoritePokemon
        }
    }
    
    @Published private var _listPokemon: [Pokemon] = []
    var listPokemon: [Pokemon] {
        get {
            return _listPokemon
        }
    }
    
    init() {
        getListFavoritePokemon()
    }
    
    private func getListFavoritePokemon() {
        _isLoadingFavoritePokemon = true
        mPokemonUseCase.getListFavoritePokemon()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { listPokemon in
                    self._isLoadingFavoritePokemon = false
                    self._listPokemon = listPokemon
                },
                onError: { error in
                    self._isLoadingFavoritePokemon = false
                }
            )
            .disposed(by: mDisposeBag)
    }
    
}
