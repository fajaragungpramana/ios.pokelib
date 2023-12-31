//
//  PokemonView.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import SwiftUI

struct PokemonView : View {
    
    @ObservedObject
    private var mViewModel = PokemonViewModel()
    
    @State private var mIsDetailPokemonClick: Bool = false
    
    private var mFlexibleGridItems: [GridItem] = [
        .init(.adaptive(minimum: 190, maximum: 360)),
        .init(.adaptive(minimum: 190, maximum: 360))
    ]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVGrid(columns: mFlexibleGridItems) {
                
                ForEach(self.mViewModel.listPokemon, id: \.id) { pokemon in
                    
                    NavigationLink {
                        DetailPokemonView(pokemon: pokemon)
                    } label: {
                        PokemonAdapterView(pokemon: pokemon)
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

struct PokemonView_Previews : PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
