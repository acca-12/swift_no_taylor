//
//  ContentView.swift
//  BookWorm
//
//  Created by Alfonso Acosta on 2024-09-22.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book] //sorting is very easy, can also make the decriptor a tuple for ascending/descending
    @State private var showingAddScreen = false
    
    //an index set is just a set of unique integers/ in this case it holds the indices of items in books that were SELECTED for deletion
    //usually contains one index
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let book = books[offset]

            // delete it from the context
            modelContext.delete(book)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) { //specifies which one we work with so the hstack can show the books contents instead of just a generic title like how we would for a single form or something
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks) //onDelete goes on the foreach not the list, that's because we want to delete an item not the list. the list doesn't have the data, the for each does.
            }
            .navigationTitle("Bookworm")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Add Book", systemImage: "plus"){
                        showingAddScreen.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                    //nice existing view
                }
            }
            .sheet(isPresented: $showingAddScreen){
                AddBookView()
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            //allows us to navigate to the detailview of the specific book
        }
    }
}

#Preview {
    ContentView()
}
