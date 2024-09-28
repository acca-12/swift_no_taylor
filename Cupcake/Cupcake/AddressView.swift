//
//  AddressView.swift
//  Cupcake
//
//  Created by Alfonso Acosta on 2024-09-21.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    //bindable creates two-way bindings that are able to work with @Observable without having to use @State to create local data
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
