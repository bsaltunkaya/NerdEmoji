//
//  AdminView.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 6.05.2024.
//

import SwiftUI

struct AdminView: View {
    var body: some View {
        VStack
        {
            NavigationLink(destination: BookAddView()) {
                                Text("Add Book")
                                    .foregroundColor(.blue)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
            NavigationLink(destination: BookRemoveView()) {
                                Text("Remove Book")
                                    .foregroundColor(.blue)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
            NavigationLink(destination: BookRemoveView()) {
                                Text("Remove User")
                                    .foregroundColor(.blue)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
        }
    }
}

#Preview {
    AdminView()
}
