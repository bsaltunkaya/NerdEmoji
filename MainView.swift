//
//  MainView.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 5.05.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack{
            Text("NerdEmoji🤓").font(.system(size:20)).bold()
            NavigationView{
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home Page", systemImage: "book.fill")
                        }
                    
                    WriteReviewView()
                        .tabItem {
                            Label("New Review", systemImage: "square.and.pencil")
                        }
                    
                    SearchView()
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("My Profile", systemImage: "person.fill")
                        }
                }
                .accentColor(.blue)  // Customize the tint color of the tab icons and text
                
                
                
            }
        }
    }
}



#Preview {
    MainView()
}
