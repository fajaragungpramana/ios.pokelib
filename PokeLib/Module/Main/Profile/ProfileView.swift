//
//  ProfileView.swift
//  PokeLib
//
//  Created by Fajar Agung Pramana on 17/07/23.
//

import SwiftUI

struct ProfileView : View {
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Image(DrawableResource.userProfile.rawValue)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                .padding(.vertical, 16)
            
            Text("user_name_profile")
                .bold()
            
            Text("user_info_profile")
                .font(.caption)
            
            Divider()
                .padding(.vertical, 16)
                .padding(.horizontal, 32)
            
            Text("user_desc_profile")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Spacer()
            
            Button {
                if let urlLinkedIn = URL(string: "https://www.linkedin.com/in/fajaragungpramana/") {
                    UIApplication.shared.open(urlLinkedIn)
                }
            } label: {
                Text("user_linkedin_profile")
                    .frame(maxWidth: .infinity)
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                        .fill(.pink)
                    )
            }
            .frame(width: 300)
            .padding(.bottom, 16)
            
        }
        
    }
    
}

struct ProfileView_Previews : PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
