//
//  ProfileView.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 6.05.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack() {
                HStack{
                    Image(systemName:"person.circle").font(.system(size:50))

                    VStack(alignment:.leading){
                        Text("User Name: John Doe")
                        Text("E-mail: doe_john@mail.com")
                    }
                }
                
                Spacer()
                NavigationLink(destination: AdminView()) {
                                    Text("Admin Menu")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(5)
                                }
            }
            .navigationBarTitle("My Profile")
            .padding()
        }
    }
}


#Preview {
    ProfileView()
}
