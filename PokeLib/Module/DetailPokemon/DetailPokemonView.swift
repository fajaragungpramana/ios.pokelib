//
//  DetailPokemonView.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 24/07/23.
//

import SwiftUI

struct DetailPokemonView : View {
    
    @Environment(\.presentationMode) private var mPresentationMode: Binding<PresentationMode>
    
    @ObservedObject
    private var mViewModel: DetailPokemonViewModel = DetailPokemonViewModel()
    
    var pokemon: Pokemon
    
    var backButton: some View {
        Button {
            mPresentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward")
        }
    }
    
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
            .frame(width: 150, height: 150)
            
            HStack {
                
                Image(DrawableResource.weightBlack.rawValue)
                    .renderingMode(.template)
                
                Text("\(pokemon.weight) KG")
                    .font(.caption)
                
                Image(DrawableResource.rulerBlack.rawValue)
                    .renderingMode(.template)
                
                Text("\(pokemon.height) M")
                    .font(.caption)
                
            }
            
            Text(mViewModel.pokemonSpecies.about)
                .font(.body)
            
        }
        .onAppear {
            mViewModel.getPokemonSpecies(id: pokemon.id)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationTitle(pokemon.name.capitalizedSentence)
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "heart")
            }
        }
        
    }
    
}
