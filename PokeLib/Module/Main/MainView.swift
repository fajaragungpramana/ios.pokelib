//
//  MainView.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 03/07/23.
//

import SwiftUI
import AlamofireNetworkActivityLogger

struct MainView : View {
    
    @State private var mSelectedTab = 1
    @State private var isNavigateToFavorite = false
    
    init() {
        setTabViewAppearance()
    }
    
    var body: some View {
        
        NavigationStack {
            
            TabView {
                
                PokemonView()
                    .tabItem() {
                        Image(DrawableResource.homeBlack.rawValue)
                            .renderingMode(.template)
                        Text("pokemon")
                    }
                    .onAppear {
                        self.mSelectedTab = 1
                    }
                
                ProfileView()
                    .tabItem() {
                        Image(DrawableResource.profileBlack.rawValue)
                            .renderingMode(.template)
                        Text("profile")
                    }
                    .onAppear {
                        self.mSelectedTab = 2
                    }
                
            }
            .onAppear {
                NetworkActivityLogger.shared.level = .debug
                NetworkActivityLogger.shared.startLogging()
            }
            .navigationBarTitle(mSelectedTab == 1 ? "pokemon" : "profile", displayMode: .inline)
            .toolbar {
                if mSelectedTab == 1 {
                    Button {
                        isNavigateToFavorite = true
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    .navigationDestination(isPresented: $isNavigateToFavorite) {
                        FavoritePokemonView()
                    }
                }
            }
            
        }
        .accentColor(.black)
        
    }
    
    private func setTabViewAppearance() {
        let image = UIImage.gradientImageWithBounds(
            bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 4),
            colors: [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.1).cgColor
            ]
        )

        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemGray6
                
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = image

        UITabBar.appearance().standardAppearance = appearance
    }
    
}

struct MainView_Previews : PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
