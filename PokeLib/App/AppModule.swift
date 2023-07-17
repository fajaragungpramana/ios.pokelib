//
//  AppInject.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import Swinject
import RxSwift

final class AppModule {
    
    static let shared = AppModule()
    private init() {}
    
    private var _container: Container?
    var container: Container {
        get {
            guard let container = _container else {
                _container = buildContainer()
                
                return _container!
            }
            
            return container
        }
        set {
            _container = newValue
        }
    }
    
    private func buildContainer() -> Container {
        let container = Container()
        
        // MARK: Common
        container.register(AppService.self) { _ in AppService() }
        container.register(DisposeBag.self) { _ in DisposeBag() }
        
        // MARK: Service
        container.register(PokemonService.self) { r in
            PokemonServiceImpl(appService: r.resolve(AppService.self)!)
        }
        
        // MARK: Repository
        container.register(PokemonRepository.self) { r in
            PokemonRepositoryImpl(
                pokemonService: r.resolve(PokemonService.self)!,
                disposeBag: r.resolve(DisposeBag.self)!
            )
        }
        
        // MARK: Domain
        container.register(PokemonUseCase.self) { r in
            PokemonInteractor(
                pokemonRepository: r.resolve(PokemonRepository.self)!,
                disposeBag: r.resolve(DisposeBag.self)!
            )
        }
        
        return container
    }
    
}

@propertyWrapper struct Inject<Dependency> {
    let wrappedValue: Dependency
    
    init() {
        self.wrappedValue = AppInject.shared.container.resolve(Dependency.self)!
    }
}
