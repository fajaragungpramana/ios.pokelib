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

    private var mFlexibleGridItems: [GridItem] = [
        .init(.adaptive(minimum: 150, maximum: 300)),
        .init(.adaptive(minimum: 150, maximum: 300)),
        .init(.adaptive(minimum: 150, maximum: 300))
    ]
    
    var pokemon: Pokemon
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var backButton: some View {
        Button {
            mPresentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward")
        }
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
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
                .frame(width: 180, height: 180)
                
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
                .padding(.vertical, 8)
                
                Text(mViewModel.pokemonSpecies.about)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
                
                LazyVGrid(columns: mFlexibleGridItems) {
                    
                    ForEach(self.pokemon.listStat, id: \.name) { stat in
                        
                        DetailPokemonStatAdapterView(stat: stat)
                        
                    }
                    
                }
                
            }
            
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
