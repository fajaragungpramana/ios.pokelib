//
//  FavoritePokemonView.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import SwiftUI

struct FavoritePokemonView : View {
    
    @Environment(\.presentationMode) private var mPresentationMode: Binding<PresentationMode>
    
    @ObservedObject
    private var mViewModel: FavoritePokemonViewModel = FavoritePokemonViewModel()
    
    private var mFlexibleGridItems: [GridItem] = [
        .init(.adaptive(minimum: 190, maximum: 360)),
        .init(.adaptive(minimum: 190, maximum: 360))
    ]
    
    var backButton: some View {
        Button {
            mPresentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward")
        }
    }
    
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
        .onAppear {
            mViewModel.getListFavoritePokemon()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationTitle("favorite")
        
    }
    
}

struct FavoritePokemonView_Previews : PreviewProvider {
    static var previews: some View {
        FavoritePokemonView()
    }
}
