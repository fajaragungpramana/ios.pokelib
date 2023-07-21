//
//  PokemonAdapterView.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 21/07/23.
//

import SwiftUI

struct PokemonAdapterView : View {
    
    var pokemon: Pokemon
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            AsyncImage(
                url: URL(string: pokemon.image),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                },
                placeholder: {
                    ProgressView()
                }
            )
            .padding(.all, 8)
            .frame(minWidth: 150, minHeight: 150)
            
            Text(pokemon.name)
                .padding(.vertical, 8)
                .bold()
            
        }
        .background(.white)
        .cornerRadius(8)
        .padding(.all, 8)
        .shadow(
            color: .black.opacity(0.3),
            radius: 2,
            x: 0,
            y: 2
        )
        
    }
    
}
