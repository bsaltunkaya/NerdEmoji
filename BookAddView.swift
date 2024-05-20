//
//  BookAddView.swift
//  NerdEmoji
//
//  Created by Bekir Sadık Altunkaya on 5.05.2024.
//
import SwiftUI
import FirebaseFirestore

struct BookAddView: View {
    @State private var name = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var isbn = ""
    @State private var year = ""
    @State private var showingSuccessAlert = false
    @State private var showingErrorAlert = false
    @State private var error: String?
    @State private var isPressed = false  // State to manage the button press visually

    var body: some View {
        NavigationView {
            VStack{
            Form {
                TextField("Enter book name", text: $name)
                TextField("Enter author", text: $author)
                TextField("Enter genre", text: $genre)
                TextField("Enter ISBN", text: $isbn)
                TextField("Enter year", text: $year)
            }
            Button("Add Book") {
                isPressed = true
                let yearInt = Int(year) ?? 0
                let bookToAdd = Book(newName: name, newAuthor: author, newGenre: genre, newISBN: isbn, newYear: yearInt)
                addBook(book: bookToAdd) { success, errorMessage in
                    if success {
                        showingSuccessAlert = true
                    } else {
                        error = errorMessage
                        showingErrorAlert = true
                    }
                    isPressed = false  
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .background(isPressed ? Color.gray : Color.blue)  // Change color on press
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(isPressed ? 0.7 : 0.9)  // Change scale on press
            .animation(.easeInOut, value: isPressed)  // Animate the transition
            .alert(isPresented: $showingSuccessAlert) {
                Alert(title: Text("Success"), message: Text("Book added successfully"), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showingErrorAlert) {
                Alert(title: Text("Error"), message: Text(error ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("Add New Book")
            }
        }
    }
}

#Preview {
    BookAddView()
}
