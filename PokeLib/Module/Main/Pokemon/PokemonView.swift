//
//  PokemonView.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import SwiftUI
import AlamofireNetworkActivityLogger

struct PokemonView : View {
    
    @ObservedObject
    private var mViewModel = PokemonViewModel()
    
    private var mFlexibleGridItems: [GridItem] = [
        .init(.adaptive(minimum: 190, maximum: 360)),
        .init(.adaptive(minimum: 190, maximum: 360))
    ]
    
    var body: some View {
        
        VStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: mFlexibleGridItems) {
                    
                    ForEach(self.mViewModel.listPokemon, id: \.id) { pokemon in
                        
                        PokemonAdapterView(pokemon: pokemon)
                        
                    }
                    
                }
                
            }
            
        }.onAppear {
            NetworkActivityLogger.shared.level = .debug
            NetworkActivityLogger.shared.startLogging()
        }
        
    }
    
}

struct PokemonView_Previews : PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
