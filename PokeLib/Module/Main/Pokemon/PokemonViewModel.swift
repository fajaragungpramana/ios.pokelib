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
    
    init() {
        getListPokemon()
    }
    
    private func getListPokemon() {
        mPokemonUseCase.getListPokemon(request: PokemonRequest())
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { listPokemon in
                    
                },
                onError: { error in
                    
                }
            ).disposed(by: mDisposeBag)
    }
    
}
