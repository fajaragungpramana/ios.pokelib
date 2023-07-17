//
//  AppInject.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import Swinject

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
        
        // Common
        container.register(AppService.self) { _ in AppService() }
        
        // Service
        container.register(PokemonService.self) { r in
            PokemonServiceImpl(appService: r.resolve(AppService.self)!)
        }
        
        // Repository
        container.register(PokemonRepository.self) { r in
            PokemonRepositoryImpl(pokemonService: r.resolve(PokemonService.self)!)
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
