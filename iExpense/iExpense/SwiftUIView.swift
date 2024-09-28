//
//  SwiftUIView.swift
//  iExpense
//
//  Created by Alfonso Acosta on 2024-09-20.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    var expenses: Expenses //now takes this parameter
    let types = ["Business", "Personal"]
    @Environment(\.dismiss) var dismiss //this lets us dismiss the sheet
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            } //button to actually add the item to expenses
        }
    }
}

#Preview {
    SwiftUIView(expenses:  Expenses()) //need to pass dummy variable to expenses (cant be empty)
}
