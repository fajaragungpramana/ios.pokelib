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
    
    var body: some View {
        
        VStack {
            
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
