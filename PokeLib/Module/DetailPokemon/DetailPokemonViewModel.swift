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
    
    /**
     * MARK: Pokemon Species State
     */
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
    
    /**
     * MARK: Set Favorite Pokemon State
     */
    @Published private var _isLoadingFavoritePokemon: Bool = false
    var isLoadingFavoritePokemon: Bool {
        get {
            return _isLoadingFavoritePokemon
        }
    }
    
    @Published private var _isFavoritePokemon: Bool = false
    var isFavoritePokemon: Bool {
        get {
            return _isFavoritePokemon
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
    
    func setFavoritePokemon(request: FavoritePokemonRequest) {
        _isLoadingFavoritePokemon = true
        mPokemonUseCase.setFavoritePokemon(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { isFavorite in
                    self._isLoadingFavoritePokemon = false
                    self._isFavoritePokemon = isFavorite
                },
                onError: { error in
                    self._isLoadingFavoritePokemon = false
                }
            )
            .disposed(by: mDisposeBag)
    }
    
    func isFavoritePokemon(id: Double) {
        _isLoadingFavoritePokemon = true
        mPokemonUseCase.isFavoritePokemon(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { isFavorite in
                    self._isLoadingFavoritePokemon = false
                    self._isFavoritePokemon = isFavorite
                },
                onError: { error in
                    self._isLoadingFavoritePokemon = false
                }
            )
            .disposed(by: mDisposeBag)
    }
    
    func deleteFavoritePokemon(id: Double) {
        _isLoadingFavoritePokemon = true
        mPokemonUseCase.deleteFavoritePokemon(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { isDelete in
                    self._isLoadingFavoritePokemon = false
                    self._isFavoritePokemon = !isDelete
                },
                onError: { error in
                    self._isLoadingFavoritePokemon = false
                }
            )
            .disposed(by: mDisposeBag)
    }
    
}
