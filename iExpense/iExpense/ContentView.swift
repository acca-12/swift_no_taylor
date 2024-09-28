//
//  ContentView.swift
//  iExpense
//
//  Created by Alfonso Acosta on 2024-09-20.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{ //protocol with id var and unique identifier
    var id = UUID() //very long hexadecimal string
    var name: String
    var type: String
    var amount: Double //everything inside already conforms to codable
}

@Observable
class Expenses {
    init() { //need to pull and decode objects from userdefault
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
                                                            //refers to the type itself
                                                            //to avoid confusion for Swift
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
    
    var items = [ExpenseItem](){
        didSet {
            //encode() can only archive objects that conform to Codable
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}


struct ContentView: View {
    @State private var expenses = Expenses() //keeps expenses objects alive
    @State private var showingAddExpense = false
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    } //to delete

    var body: some View {
        NavigationStack{
            List{
                ForEach(expenses.items) { item in //can get rid of id since we have identifiable
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true //shows sheet
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            SwiftUIView(expenses: expenses) //when we pull down a sheet we want to call this view //share existing instance of Expenses(), so we can share data across 
        }
    }
}

#Preview {
    ContentView()
}
