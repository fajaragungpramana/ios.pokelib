//
//  FavoritePokemonView.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 25/07/23.
//

import SwiftUI

struct FavoritePokemonView : View {
    
    @Environment(\.presentationMode) private var mPresentationMode: Binding<PresentationMode>
    
    var backButton: some View {
        Button {
            mPresentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward")
        }
    }
    
    var body: some View {
        
        VStack {
            
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
