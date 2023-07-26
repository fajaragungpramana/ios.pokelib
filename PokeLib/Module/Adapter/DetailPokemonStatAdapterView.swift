//
//  DetailPokemonStatAdapterView.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 24/07/23.
//

import SwiftUI

struct DetailPokemonStatAdapterView : View {
    
    var stat: Stat
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            Circle()
                .trim(from: 0, to: CGFloat(Double(stat.value) / 100.0))
                .stroke(
                    Color.pink,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            
            Text(stat.name)
                .bold()
            
        }
        .padding(16)
        
    }
    
}
