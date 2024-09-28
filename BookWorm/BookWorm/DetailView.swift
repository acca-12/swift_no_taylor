//
//  DetailView.swift
//  BookWorm
//
//  Created by Alfonso Acosta on 2024-09-22.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    let book: Book
    func deleteBook() {
        modelContext.delete(book)
        dismiss() //dismiss used to dismiss sheets or pop current view from nav stack
        //to dismiss everything with something like a home button, please use a navpath
    }
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()

                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)

            Text(book.review)
                .padding()

            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }//automatically toggled off
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
}

#Preview {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Book.self, configurations: config)
            let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)

            return DetailView(book: example)
                .modelContainer(container)
        } catch {
            return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
//need to make a model container by hand so that it doesn't store anything and store the info in memory only, meaning it'll be temporary
